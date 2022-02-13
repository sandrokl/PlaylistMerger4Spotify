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

  Future<void> deleteAll() async {
    await delete(tracksCurrent).go();
  }
}
