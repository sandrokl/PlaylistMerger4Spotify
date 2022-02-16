import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_new_distinct.dart';

part 'tracks_new_distinct_dao.g.dart';

@DriftAccessor(tables: [TracksNewDistinct])
class TracksNewDistinctDao extends DatabaseAccessor<AppDatabase> with _$TracksNewDistinctDaoMixin {
  TracksNewDistinctDao(AppDatabase db) : super(db);

  Future<void> deleteAll(int jobId) async {
    await (delete(tracksNewDistinct)..where((t) => t.jobId.equals(jobId))).go();
  }

  Future<void> insertAll(List<Track> tracks) async {
    await batch((batch) async {
      batch.insertAllOnConflictUpdate(
        tracksNewDistinct,
        tracks,
      );
    });
  }

  Future<List<Track>> getTracksNotInCurrent(int jobId) async {
    var currentTracksIds = await db.tracksCurrentDao.getAllTracksIds(jobId);
    return (select(tracksNewDistinct)..where((t) => t.jobId.equals(jobId) & t.trackId.isNotIn(currentTracksIds))).get();
  }

  Future<List<String?>> getAllTracksIds(int jobId) async {
    var queryTracksIds = selectOnly(tracksNewDistinct, distinct: true)
      ..addColumns([tracksNewDistinct.trackId])
      ..where(tracksNewDistinct.jobId.equals(jobId));
    var values = await queryTracksIds.map((t) => t.read(tracksNewDistinct.trackId)).get();
    return values;
  }
}
