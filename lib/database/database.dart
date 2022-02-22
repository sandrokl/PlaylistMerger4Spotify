import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:playlistmerger4spotify/database/dao/merging_results_dao.dart';
import 'package:playlistmerger4spotify/database/dao/playlists_dao.dart';
import 'package:playlistmerger4spotify/database/dao/playlists_to_merge_dao.dart';
import 'package:playlistmerger4spotify/database/dao/tracks_current_dao.dart';
import 'package:playlistmerger4spotify/database/dao/tracks_new_all_dao.dart';
import 'package:playlistmerger4spotify/database/dao/tracks_new_distinct_dao.dart';
import 'package:playlistmerger4spotify/database/dao/tracks_to_add_dao.dart';
import 'package:playlistmerger4spotify/database/dao/tracks_to_remove_dao.dart';
import 'package:playlistmerger4spotify/database/models/merging_results.dart';
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

@DriftDatabase(
  tables: [
    Playlists,
    PlaylistsToMerge,
    TracksCurrent,
    TracksNewAll,
    TracksNewDistinct,
    TracksToRemove,
    TracksToAdd,
    MergingResults,
  ],
  daos: [
    PlaylistsDao,
    PlaylistsToMergeDao,
    TracksCurrentDao,
    TracksNewAllDao,
    TracksNewDistinctDao,
    TracksToAddDao,
    TracksToRemoveDao,
    MergingResultsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  static final AppDatabase _singleton = AppDatabase._internal();
  AppDatabase._internal() : super(_openConnection());
  factory AppDatabase() => _singleton;

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (_) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement('PRAGMA journal_mode=WAL');
          await customStatement('PRAGMA busy_timeout=90000');
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
            } catch (_) {/* column already exists */}
          }

          if (from <= 4) {
            try {
              await m.addColumn(tracksCurrent, tracksCurrent.jobId);
              await m.addColumn(tracksNewAll, tracksNewAll.jobId);
              await m.addColumn(tracksNewDistinct, tracksNewDistinct.jobId);
              await m.addColumn(tracksToAdd, tracksToAdd.jobId);
              await m.addColumn(tracksToRemove, tracksToRemove.jobId);
            } catch (_) {/* column already exists */}
          }

          if (from <= 7) {
            try {
              await m.addColumn(mergingResults, mergingResults.triggeredBy);
            } catch (_) {/* column already exists */}
          }

          if (from <= 8) {
            try {
              await m.addColumn(mergingResults, mergingResults.tracksAdded);
              await m.addColumn(mergingResults, mergingResults.tracksRemoved);
            } catch (_) {/* column already exists */}
          }
        },
      );
}
