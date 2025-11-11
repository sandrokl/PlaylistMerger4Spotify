import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_to_remove.dart';

part 'tracks_to_remove_dao.g.dart';

@DriftAccessor(tables: [TracksToRemove])
class TracksToRemoveDao extends DatabaseAccessor<AppDatabase> with _$TracksToRemoveDaoMixin {
  TracksToRemoveDao(super.db);

  Future<void> insertAll(List<Track> listToInsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(tracksToRemove, listToInsert);
    });
  }

  Future<void> deleteAll(int jobId) async {
    await (delete(tracksToRemove)..where((t) => t.jobId.equals(jobId))).go();
  }

  Future<List<Track>> getAll(int jobId) async {
    return (select(tracksToRemove)..where((t) => t.jobId.equals(jobId))).get();
  }
}
