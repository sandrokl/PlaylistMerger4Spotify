import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';

class MergingHelper {
  static final MergingHelper _mergingHelper = MergingHelper._internal();
  factory MergingHelper() => _mergingHelper;
  MergingHelper._internal();

  final _db = AppDatabase();
  final _databaseBatchSize = 100;

  Future<void> clearTracksInDB() async {
    await _db.tracksCurrentDao.deleteAll();
    await _db.tracksNewAllDao.deleteAll();
    await _db.tracksNewDistinctDao.deleteAll();
    await _db.tracksToAddDao.deleteAll();
    await _db.tracksToRemoveDao.deleteAll();
  }

  Future<void> updateAllMergedPlaylists() async {
    //await updateSpecificMergedPlaylist("abc", showNotification: false);

    // shrink empty space from database
    await _db.customStatement("VACUUM;");
  }

  Future<bool> updateSpecificMergedPlaylist(String playlistId) async {
    try {
      // STEP 0 : clear all records of tracks, just to be sure
      await clearTracksInDB();

      var tracks = <Track>[];

      // STEP 1 : get current tracks in merged playlist
      await for (var track in SpotifyClient().getTracksFromPlaylist(playlistId)) {
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
        await for (var track in SpotifyClient().getTracksFromPlaylist(source.sourcePlaylistId)) {
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
      var tracksWithoutDuplicates = await _db.tracksNewAllDao.getTracksWithoutDuplicates();
      await _db.tracksNewDistinctDao.insertAll(tracksWithoutDuplicates);

      // STEP 4: generate list of tracks to add
      var tracksToAdd = await _db.tracksNewDistinctDao.getTracksNotInCurrent();
      await _db.tracksToAddDao.insertAll(tracksToAdd);

      // STEP 5: generate list of tracks to remove
      var tracksToRemove = await _db.tracksCurrentDao.getTracksNotNewDistinct();
      await _db.tracksToRemoveDao.insertAll(tracksToRemove);

      // STEP 6: add tracks to Spotify

      // STEP 7: remove tracks from Spotify

      // STEP N : clear tracks from DB
      await clearTracksInDB();

      return true;
    } catch (_) {
      return false;
    }
  }
}
