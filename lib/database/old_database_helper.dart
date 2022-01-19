import 'dart:io';
import 'package:path/path.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:sqflite/sqflite.dart';

Future<String> _getDbName() async {
  var databasesPath = await getDatabasesPath();
  return join(databasesPath, "playlistmerger4spotify._db");
}

Future<void> migrateDataFromV1() async {
  var dbFile = File(await _getDbName());
  if (await dbFile.exists()) {
    Database? oldDB;

    try {
      oldDB = await openDatabase(await _getDbName());

      // get all the playlists from the previous version
      var playlistsFromDB = await oldDB.query('UserPlaylists');
      var playlistsToInsert = playlistsFromDB.map((p) => Playlist(
          playlistId: p["PlaylistId"].toString(),
          name: p["Name"].toString(),
          ownerId: p["OwnerId"].toString(),
          tracksUrl: p["TracksURL"].toString(),
          playUrl: p["PlayURL"].toString(),
          isValidated: false));

      // get all the playlists to merge from the previous version
      var pToMergeFromDB = await oldDB.query('PlaylistsToMerge');
      var playlistToMergeToInsert = pToMergeFromDB.map((pm) {
        return PlaylistToMerge(
          destinationPlaylistId: pm['DestinationPlaylistId'].toString(),
          sourcePlaylistId: pm['SourcePlaylistId'].toString(),
        );
      }).where((pm) {
        return playlistsToInsert
                .any((p) => p.playlistId == pm.destinationPlaylistId) &&
            playlistsToInsert.any((p) => p.playlistId == pm.sourcePlaylistId);
      });

      final newDB = AppDatabase();
      newDB.batch((batch) =>
          batch.insertAllOnConflictUpdate(newDB.playlists, playlistsToInsert));

      newDB.batch((batch) => batch.insertAllOnConflictUpdate(
          newDB.playlistsToMerge, playlistToMergeToInsert));

      await oldDB.close();
      await dbFile.delete();
      oldDB = null;
    } finally {
      if (oldDB != null && oldDB.isOpen) await oldDB.close();
    }
  }
}
