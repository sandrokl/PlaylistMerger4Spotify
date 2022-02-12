import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:playlistmerger4spotify/database/dao/playlists_dao.dart';
import 'package:playlistmerger4spotify/database/dao/playlists_to_merge_dao.dart';
import 'package:playlistmerger4spotify/database/models/tracks_current.dart';
import 'package:playlistmerger4spotify/database/models/tracks_new_all.dart';
import 'package:playlistmerger4spotify/database/models/tracks_new_distinct.dart';
import 'package:playlistmerger4spotify/database/models/playlists.dart';
import 'package:playlistmerger4spotify/database/models/playlists_to_merge.dart';
import 'package:playlistmerger4spotify/database/models/tracks_to_add.dart';
import 'package:playlistmerger4spotify/database/models/tracks_to_remove.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'old_database_helper.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await sqflite.getDatabasesPath();
    final file = File(p.join(dbFolder, 'pm4s-v2.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  Playlists,
  PlaylistsToMerge,
  TracksCurrent,
  TracksNewAll,
  TracksNewDistinct,
  TracksToRemove,
  TracksToAdd
], daos: [
  PlaylistsDao,
  PlaylistsToMergeDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (_) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (m) async {
          await m.createAll();

          await migrateDataFromV1();
        },
        onUpgrade: (m, from, to) async {
          await m.createAll();

          if (from <= 3) {
            try {
              await m.addColumn(tracksCurrent, tracksCurrent.addedAt);
              await m.addColumn(tracksNewAll, tracksNewAll.addedAt);
              await m.addColumn(tracksNewDistinct, tracksNewDistinct.addedAt);
              await m.addColumn(tracksToAdd, tracksToAdd.addedAt);
              await m.addColumn(tracksToRemove, tracksToRemove.addedAt);
            } catch (e) {/* column already exists */}
          }
        },
      );
}
