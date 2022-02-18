import 'dart:math';

import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';

class MergingHelper {
  static final MergingHelper _mergingHelper = MergingHelper._internal();
  factory MergingHelper() => _mergingHelper;
  MergingHelper._internal();

  final _db = AppDatabase();
  final _databaseBatchSize = 100;
  final _spotifyClient = SpotifyClient();

  Future<void> clearTracksInDB(int jobId) async {
    await _db.tracksCurrentDao.deleteAll(jobId);
    await _db.tracksNewAllDao.deleteAll(jobId);
    await _db.tracksNewDistinctDao.deleteAll(jobId);
    await _db.tracksToAddDao.deleteAll(jobId);
    await _db.tracksToRemoveDao.deleteAll(jobId);
  }

  Future<bool> updateAllMergedPlaylists(
    String notificationInProgressChannelId,
    String notificationInProgressChannelName,
    String notificationInProgressMessage,
  ) async {
    try {
      var mergingPlaylists = await _db.playlistsToMergeDao.getCurrentDestinationPlaylistsIds();
      if (mergingPlaylists.isNotEmpty) {
        for (var id in mergingPlaylists) {
          if (id != null) {
            var result = await updateSpecificMergedPlaylist(
              id,
              notificationInProgressChannelId,
              notificationInProgressChannelName,
              notificationInProgressMessage,
            );
            if (!result) {
              throw Exception("FAILED");
            }
          }
        }
      }

      await _db.mergingResultsDao.cleanOldRecords(30);
      // shrink empty space from database
      await _db.customStatement("VACUUM;");
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateSpecificMergedPlaylist(
    String playlistId,
    String notificationInProgressChannelId,
    String notificationInProgressChannelName,
    String notificationInProgressMessage,
  ) async {
    final jobId = Random().nextInt(9999999);
    final notif = NotificationsHelper();
    final startDate = DateTime.now();

    try {
      await notif.showPersistentNotification(
        jobId,
        notificationInProgressChannelId,
        notificationInProgressChannelName,
        notificationInProgressMessage,
      );

      // STEP 0 : clear all records of tracks, just to be sure
      await clearTracksInDB(jobId);

      var tracks = <Track>[];

      // STEP 1 : get current tracks in merged playlist
      await for (var track in _spotifyClient.getTracksFromPlaylist(playlistId)) {
        track.jobId = jobId;
        tracks.add(track);
        if (tracks.length == _databaseBatchSize) {
          await _db.tracksCurrentDao.insertAll(tracks);
          tracks.clear();
        }
      }
      if (tracks.isNotEmpty) {
        await _db.tracksCurrentDao.insertAll(tracks);
        tracks.clear();
      }

      // STEP 2 : get all tracks from source playlists
      var sources = await _db.playlistsToMergeDao.getPlaylistsToMergeByDestinationId(playlistId);
      for (var source in sources) {
        await for (var track in _spotifyClient.getTracksFromPlaylist(source.sourcePlaylistId)) {
          track.jobId = jobId;
          tracks.add(track);
          if (tracks.length == _databaseBatchSize) {
            await _db.tracksNewAllDao.insertAll(tracks);
            tracks.clear();
          }
        }
        if (tracks.isNotEmpty) {
          await _db.tracksNewAllDao.insertAll(tracks);
          tracks.clear();
        }
      }

      // STEP 3 : remove duplicates from new tracks
      var tracksWithoutDuplicates = await _db.tracksNewAllDao.getTracksWithoutDuplicates(jobId);
      await _db.tracksNewDistinctDao.insertAll(tracksWithoutDuplicates);

      // STEP 4: generate list of tracks to add
      var tracksToAdd = await _db.tracksNewDistinctDao.getTracksNotInCurrent(jobId);
      await _db.tracksToAddDao.insertAll(tracksToAdd);

      // STEP 5: generate list of tracks to remove
      var tracksToRemove = await _db.tracksCurrentDao.getTracksNotNewDistinct(jobId);
      await _db.tracksToRemoveDao.insertAll(tracksToRemove);

      // STEP 6: add tracks to Spotify
      tracksToAdd = await _db.tracksToAddDao.getAll(jobId);
      if (tracksToAdd.isNotEmpty) {
        await _spotifyClient.insertTracksInPlaylist(playlistId, tracksToAdd);
      }

      // STEP 7: remove tracks from Spotify
      tracksToRemove = await _db.tracksToRemoveDao.getAll(jobId);
      if (tracksToRemove.isNotEmpty) {
        await _spotifyClient.removeTracksInPlaylist(playlistId, tracksToRemove);
      }

      // STEP N : clear tracks from DB
      await clearTracksInDB(jobId);
      await notif.dismissPersistentNotification(jobId);

      await _db.mergingResultsDao.insert(MergingResult(
        playlistId: playlistId,
        runDate: DateTime.now(),
        successed: true,
        durationMs: DateTime.now().difference(startDate).inMilliseconds,
      ));

      return true;
    } catch (_) {
      await notif.dismissPersistentNotification(jobId);
      await _db.mergingResultsDao.insert(MergingResult(
        playlistId: playlistId,
        runDate: DateTime.now(),
        successed: false,
        durationMs: DateTime.now().difference(startDate).inMilliseconds,
      ));
      return false;
    }
  }
}
