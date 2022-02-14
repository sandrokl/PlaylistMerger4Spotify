import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_to_add.dart';

part 'tracks_to_add_dao.g.dart';

@DriftAccessor(tables: [TracksToAdd])
class TracksToAddDao extends DatabaseAccessor<AppDatabase> with _$TracksToAddDaoMixin {
  TracksToAddDao(AppDatabase db) : super(db);

  Future<void> insertAll(List<Track> listToInsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(tracksToAdd, listToInsert);
    });
  }

  Future<void> deleteAll() async {
    await delete(tracksToAdd).go();
  }

  Future<List<Track>> getAll() {
    return select(tracksToAdd).get();
  }
}
