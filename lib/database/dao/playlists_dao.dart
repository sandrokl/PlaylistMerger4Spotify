import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/playlists.dart';

part 'playlists_dao.g.dart';

@DriftAccessor(tables: [Playlists])
class PlaylistsDao extends DatabaseAccessor<AppDatabase>
    with _$PlaylistsDaoMixin {
  PlaylistsDao(AppDatabase db) : super(db);

  Future<List<Playlist>> getAllUserPlaylists() {
    return select(playlists).get();
  }

  Future<void> invalidateAllPlaylists() async {
    await (update(playlists)..where((tbl) => tbl.isValidated))
        .write(const PlaylistsCompanion(isValidated: Value(false)));
  }

  Future<void> insertAll(List<Playlist> listToInsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(playlists, listToInsert);
    });
  }

  Future<void> deleteAllInvalidatedPlaylists() async {
    await (delete(playlists)..where((tbl) => tbl.isValidated.not())).go();
  }

  Future<List<Playlist>> getMergedPlaylists() async {
    var query1 = selectOnly(db.playlistsToMerge, distinct: true)
      ..addColumns([db.playlistsToMerge.destinationPlaylistId]);
    var values = await query1
        .map((p) => p.read(db.playlistsToMerge.destinationPlaylistId))
        .get();

    if (values.isEmpty) return [];
    return (select(playlists)
          ..where((tbl) => tbl.playlistId.isIn(values))
          ..orderBy([(p) => OrderingTerm(expression: p.name)]))
        .get();
  }
}
