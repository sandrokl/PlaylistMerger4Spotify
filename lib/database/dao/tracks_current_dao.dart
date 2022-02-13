import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_current.dart';

part 'tracks_current_dao.g.dart';

@DriftAccessor(tables: [TracksCurrent])
class TracksCurrentDao extends DatabaseAccessor<AppDatabase> with _$TracksCurrentDaoMixin {
  TracksCurrentDao(AppDatabase db) : super(db);

  Future<void> insertAll(List<Track> listToInsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(tracksCurrent, listToInsert);
    });
  }

  Future<List<String?>> getAllTracksIds() async {
    var queryTracksIds = selectOnly(tracksCurrent, distinct: true)..addColumns([tracksCurrent.trackId]);
    var values = await queryTracksIds.map((t) => t.read(tracksCurrent.trackId)).get();
    return values;
  }

  Future<void> deleteAll() async {
    await delete(tracksCurrent).go();
  }

  Future<List<Track>> getTracksNotNewDistinct() async {
    var newDistinctTracksIds = await db.tracksNewDistinctDao.getAllTracksIds();
    return (select(tracksCurrent)..where((t) => t.trackId.isNotIn(newDistinctTracksIds))).get();
  }
}
