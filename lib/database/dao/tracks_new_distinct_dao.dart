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

  Future<void> generateNewTracksWithoutDuplicates() async {
    var query = customSelect(
      """select playlist_id, track_id, track_artists, name, track_uri, duration_ms, added_at
        from tracks_new_all 
        group by name, track_artists
        HAVING ROWID = MIN(ROWID)
        order by added_at desc;""",
      readsFrom: {db.tracksNewAll},
    ).get();
    var tracksToInsert = (await query).map((row) => Track.fromData(row.data)).toList();

    await batch((batch) async {
      batch.insertAllOnConflictUpdate(
        tracksNewDistinct,
        tracksToInsert,
      );
    });
  }
}
