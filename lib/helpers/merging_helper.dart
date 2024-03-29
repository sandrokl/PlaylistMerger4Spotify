import 'dart:math';

import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/merging_results.dart';
import 'package:playlistmerger4spotify/helpers/deduplicator_helper.dart';
import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';

class MergingHelper {
  static final MergingHelper _instance = MergingHelper._internal();
  factory MergingHelper() => _instance;
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
    await _db.tracksToExcludeDao.deleteAll(jobId);
  }

  Future<bool> updateAllMergedPlaylists(
    String notificationInProgressChannelId,
    String notificationInProgressChannelName,
    String notificationInProgressMessage, {
    bool isAutomaticUpdate = false,
  }) async {
    try {
      var mergingPlaylists = await _db.playlistsToMergeDao.getCurrentDestinationPlaylistsIds();
      if (mergingPlaylists.isNotEmpty) {
        bool hasFailure = false;

        for (var id in mergingPlaylists) {
          if (id != null) {
            bool shouldUpdate = true;

            if (isAutomaticUpdate) {
              final now = DateTime.now();
              if (now.hour < 2) {
                shouldUpdate = false;
              } else {
                final MergingResult? lastSuccessfulUpdate = await _db.mergingResultsDao.getLastSuccessfulUpdate(id);
                if (lastSuccessfulUpdate != null) {
                  if (lastSuccessfulUpdate.runDate.year == now.year &&
                      lastSuccessfulUpdate.runDate.month == now.month &&
                      lastSuccessfulUpdate.runDate.day == now.day) {
                    shouldUpdate = false;
                  }
                }
              }
            }

            if (shouldUpdate) {
              var result = await updateSpecificMergedPlaylist(
                id,
                notificationInProgressChannelId,
                notificationInProgressChannelName,
                notificationInProgressMessage,
                isAutomaticUpdate: isAutomaticUpdate,
              );
              if (!result) {
                hasFailure = true;
              }
            }
          }
        }

        if (hasFailure) {
          throw Exception("FAILED");
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
    String notificationInProgressMessage, {
    bool isAutomaticUpdate = false,
  }) async {
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

      // STEP 4.1 : get tracks from playlists to exclude from merging
      var exclusions = await _db.playlistsToIgnoreDao.getByDestinationId(playlistId);
      for (var exclusion in exclusions) {
        await for (var track in _spotifyClient.getTracksFromPlaylist(exclusion.playlistId)) {
          track.jobId = jobId;
          tracks.add(track);
          if (tracks.length == _databaseBatchSize) {
            await _db.tracksToExcludeDao.insertAll(tracks);
            tracks.clear();
          }
        }
        if (tracks.isNotEmpty) {
          await _db.tracksToExcludeDao.insertAll(tracks);
          tracks.clear();
        }
      }

      // STEP 4.2 : remove tracks from step 4.1 from tracksNewDistinct
      var ids = await _db.tracksNewDistinctDao.getTracksToIgnore(jobId);
      await _db.tracksNewDistinctDao.deleteByIds(jobId, ids);

      // STEP 5: generate list of tracks to add
      var tracksToAdd = await _db.tracksNewDistinctDao.getTracksNotInCurrent(jobId);

      // STEP 5.1: remove local tracks from tracks to add (not supported in the API)
      tracksToAdd = tracksToAdd.where((e) => !e.trackUri.startsWith("spotify:local:")).toList();

      // STEP 5.2: add to database
      await _db.tracksToAddDao.insertAll(tracksToAdd);

      // STEP 6: generate list of tracks to remove
      var tracksToRemove = await _db.tracksCurrentDao.getTracksNotNewDistinct(jobId);
      await _db.tracksToRemoveDao.insertAll(tracksToRemove);

      // STEP 7: add tracks to Spotify
      tracksToAdd = await _db.tracksToAddDao.getAll(jobId);
      if (tracksToAdd.isNotEmpty) {
        await _spotifyClient.insertTracksInPlaylist(playlistId, tracksToAdd);
      }

      // STEP 8: remove tracks from Spotify
      tracksToRemove = await _db.tracksToRemoveDao.getAll(jobId);
      if (tracksToRemove.isNotEmpty) {
        await _spotifyClient.removeTracksByIdInPlaylist(playlistId, tracksToRemove);
      }

      // STEP 9: if a Spotify bug caused duplicates, remove them
      final nbRemovedDuplicates = await DeduplicatorHelper().deduplicateTracks(playlistId);

      // STEP N : clear tracks from DB
      // await clearTracksInDB(jobId);
      await notif.dismissPersistentNotification(jobId);

      await _db.mergingResultsDao.insert(MergingResult(
        playlistId: playlistId,
        runDate: DateTime.now(),
        successed: true,
        durationMs: DateTime.now().difference(startDate).inMilliseconds,
        triggeredBy: isAutomaticUpdate ? TriggeredBy.schedule : TriggeredBy.user,
        tracksAdded: tracksToAdd.length,
        tracksRemoved: tracksToRemove.length + nbRemovedDuplicates,
      ));

      return true;
    } catch (_) {
      await notif.dismissPersistentNotification(jobId);
      await _db.mergingResultsDao.insert(MergingResult(
        playlistId: playlistId,
        runDate: DateTime.now(),
        successed: false,
        durationMs: DateTime.now().difference(startDate).inMilliseconds,
        triggeredBy: isAutomaticUpdate ? TriggeredBy.schedule : TriggeredBy.user,
      ));
      return false;
    }
  }
}
