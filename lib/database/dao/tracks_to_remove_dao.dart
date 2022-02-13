import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_to_remove.dart';

part 'tracks_to_remove_dao.g.dart';

@DriftAccessor(tables: [TracksToRemove])
class TracksToRemoveDao extends DatabaseAccessor<AppDatabase> with _$TracksToRemoveDaoMixin {
  TracksToRemoveDao(AppDatabase db) : super(db);

  Future<void> insertAll(List<Track> listToInsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(tracksToRemove, listToInsert);
    });
  }

  Future<void> deleteAll() async {
    await delete(tracksToRemove).go();
  }
}
