import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:playlistmerger_4_spotify/database/dao/playlists_dao.dart';
import 'package:playlistmerger_4_spotify/database/dao/playlists_to_merge_dao.dart';
import 'package:playlistmerger_4_spotify/database/dao/tracks_dao.dart';
import 'package:playlistmerger_4_spotify/database/models/playlists.dart';
import 'package:playlistmerger_4_spotify/database/models/playlists_to_merge.dart';
import 'package:playlistmerger_4_spotify/database/models/tracks.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pm4s.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
    tables: [Playlists, PlaylistsToMerge, Tracks],
    daos: [PlaylistsDao, PlaylistsToMergeDao, TracksDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (_) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          await m.createAll();

          // EXAMPLE :
          // if (from <= 1) {
          // try {
          //   await m.addColumn(tracks, tracks.trackArtists);
          // } catch (e) {/* column already exists */}
          // }
        },
      );
}
