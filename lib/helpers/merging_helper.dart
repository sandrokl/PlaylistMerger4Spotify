import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';

class MergingHelper {
  static final MergingHelper _mergingHelper = MergingHelper._internal();
  factory MergingHelper() => _mergingHelper;
  MergingHelper._internal();

  final _db = AppDatabase();
  final _databaseBatchSize = 100;

  Future<void> updateAllMergedPlaylists() async {
    //await updateSpecificMergedPlaylist("abc", showNotification: false);
  }

  Future<bool> updateSpecificMergedPlaylist(String playlistId) async {
    try {
      // STEP 0 : clean all records of tracks
      await _db.tracksCurrentDao.deleteAll();
      await _db.tracksNewAllDao.deleteAll();

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
      return true;
    } catch (_) {
      return false;
    }
  }
}
