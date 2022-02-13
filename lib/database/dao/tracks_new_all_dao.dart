import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_new_all.dart';

part 'tracks_new_all_dao.g.dart';

@DriftAccessor(tables: [TracksNewAll])
class TracksNewAllDao extends DatabaseAccessor<AppDatabase> with _$TracksNewAllDaoMixin {
  TracksNewAllDao(AppDatabase db) : super(db);

  Future<void> insertAll(List<Track> listToInsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(tracksNewAll, listToInsert);
    });
  }

  Future<void> deleteAll() async {
    await delete(tracksNewAll).go();
  }
}
