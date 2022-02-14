import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_new_distinct.dart';

part 'tracks_new_distinct_dao.g.dart';

@DriftAccessor(tables: [TracksNewDistinct])
class TracksNewDistinctDao extends DatabaseAccessor<AppDatabase> with _$TracksNewDistinctDaoMixin {
  TracksNewDistinctDao(AppDatabase db) : super(db);

  Future<void> deleteAll() async {
    await delete(tracksNewDistinct).go();
  }

  Future<void> insertAll(List<Track> tracks) async {
    await batch((batch) async {
      batch.insertAllOnConflictUpdate(
        tracksNewDistinct,
        tracks,
      );
    });
  }

  Future<List<Track>> getTracksNotInCurrent() async {
    var currentTracksIds = await db.tracksCurrentDao.getAllTracksIds();
    return (select(tracksNewDistinct)..where((t) => t.trackId.isNotIn(currentTracksIds))).get();
  }

  Future<List<String?>> getAllTracksIds() async {
    var queryTracksIds = selectOnly(tracksNewDistinct, distinct: true)..addColumns([tracksNewDistinct.trackId]);
    var values = await queryTracksIds.map((t) => t.read(tracksNewDistinct.trackId)).get();
    return values;
  }
}
