import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_new_all.dart';

part 'tracks_new_all_dao.g.dart';

@DriftAccessor(tables: [TracksNewAll])
class TracksNewAllDao extends DatabaseAccessor<AppDatabase>
    with _$TracksNewAllDaoMixin {
  TracksNewAllDao(AppDatabase db) : super(db);

  Future<void> insertAll(List<Track> listToInsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(tracksNewAll, listToInsert);
    });
  }

  Future<List<Track>> getTracksWithoutDuplicates(int jobId) async {
    var rows = await customSelect(
      """select job_id, playlist_id, track_id, track_artists, name, track_uri, duration_ms, added_at
        from tracks_new_all 
        where job_id = ?
        group by name, track_artists
        HAVING ROWID = MIN(ROWID)
        order by added_at ASC;""",
      variables: [Variable.withInt(jobId)],
      readsFrom: {db.tracksNewAll},
    ).get();
    return rows.map((row) => Track.fromMap(row.data)).toList();
  }

  Future<void> deleteAll(int jobId) async {
    await (delete(tracksNewAll)..where((t) => t.jobId.equals(jobId))).go();
  }
}
