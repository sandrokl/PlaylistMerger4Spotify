import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_to_exclude.dart';

part 'tracks_to_exclude_dao.g.dart';

@DriftAccessor(tables: [TracksToExclude])
class TracksToExcludeDao extends DatabaseAccessor<AppDatabase> with _$TracksToExcludeDaoMixin {
  TracksToExcludeDao(super.db);

  Future<void> insertAll(List<Track> listToInsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(tracksToExclude, listToInsert);
    });
  }

  Future<void> deleteAll(int jobId) async {
    await (delete(tracksToExclude)..where((t) => t.jobId.equals(jobId))).go();
  }

  Future<List<Track>> getAll(int jobId) {
    return (select(tracksToExclude)..where((t) => t.jobId.equals(jobId))).get();
  }
}
