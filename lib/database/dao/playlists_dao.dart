import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/playlists.dart';

part 'playlists_dao.g.dart';

@DriftAccessor(tables: [Playlists])
class PlaylistsDao extends DatabaseAccessor<AppDatabase> with _$PlaylistsDaoMixin {
  PlaylistsDao(super.db);

  Future<List<Playlist>> getAllUserPlaylists() {
    return (select(playlists)..orderBy([(p) => OrderingTerm(expression: p.name.upper())])).get();
  }

  Future<List<Playlist>> getPlaylistsByIdList(List<String> ids) {
    return (select(playlists)
          ..where((p) => p.playlistId.isIn(ids))
          ..orderBy([(p) => OrderingTerm(expression: p.name.upper())]))
        .get();
  }

  Future<List<Playlist>> getPossibleNewMergingPlaylists(String userId) async {
    var alreadyUsedPlaylists = await db.playlistsToMergeDao.getCurrentDestinationPlaylistsIds();

    return (select(playlists)
          ..where(
            (p) =>
                p.ownerId.equals(userId) &
                p.playlistId.isNotIn(alreadyUsedPlaylists.map((e) => e!)),
          )
          ..orderBy([(p) => OrderingTerm(expression: p.name.upper())]))
        .get();
  }

  Future<void> invalidateAllPlaylists() async {
    await (update(
      playlists,
    )..where((tbl) => tbl.isValidated)).write(const PlaylistsCompanion(isValidated: Value(false)));
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
    var values = await db.playlistsToMergeDao.getCurrentDestinationPlaylistsIds();

    if (values.isEmpty) return [];
    return (select(playlists)
          ..where((tbl) => tbl.playlistId.isIn(values.map((e) => e!)))
          ..orderBy([(p) => OrderingTerm(expression: p.name.upper())]))
        .get();
  }
}
