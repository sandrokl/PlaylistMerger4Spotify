import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/playlists_to_ignore.dart';

part 'playlists_to_ignore_dao.g.dart';

@DriftAccessor(tables: [PlaylistsToIgnore])
class PlaylistsToIgnoreDao extends DatabaseAccessor<AppDatabase> with _$PlaylistsToIgnoreDaoMixin {
  PlaylistsToIgnoreDao(AppDatabase db) : super(db);

  Future<List<PlaylistToIgnore>> getByDestinationId(String destinationId) {
    return (select(playlistsToIgnore)..where((p) => p.destinationPlaylistId.equals(destinationId))).get();
  }

  Future<void> deletePlaylistsToIgnoreByDestinationId(String destinationPlaylistId) async {
    await (delete(playlistsToIgnore)..where((p) => p.destinationPlaylistId.equals(destinationPlaylistId))).go();
  }

  Future<void> updateIgnoredPlaylists(
    String destinationPlaylistId,
    List<PlaylistToIgnore> listToIgnore, {
    bool deleteBeforeInsert = true,
  }) async {
    final listWithDestinationId = listToIgnore
        .map((e) => PlaylistToIgnore(
            destinationPlaylistId: destinationPlaylistId,
            name: e.name,
            openUrl: e.openUrl,
            ownerId: e.ownerId,
            ownerName: e.ownerName,
            playlistId: e.playlistId))
        .toList();
    db.batch((batch) {
      if (deleteBeforeInsert) {
        batch.deleteWhere(
            playlistsToIgnore, (_) => playlistsToIgnore.destinationPlaylistId.equals(destinationPlaylistId));
      }

      batch.insertAllOnConflictUpdate(playlistsToIgnore, listWithDestinationId);
    });
  }
}
