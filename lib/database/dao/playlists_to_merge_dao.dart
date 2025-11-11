import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/playlists_to_merge.dart';

part 'playlists_to_merge_dao.g.dart';

@DriftAccessor(tables: [PlaylistsToMerge])
class PlaylistsToMergeDao extends DatabaseAccessor<AppDatabase> with _$PlaylistsToMergeDaoMixin {
  PlaylistsToMergeDao(super.db);

  Future<List<String?>> getCurrentDestinationPlaylistsIds() async {
    var queryDestinationPlaylists = selectOnly(db.playlistsToMerge, distinct: true)
      ..addColumns([db.playlistsToMerge.destinationPlaylistId]);
    var values = await queryDestinationPlaylists
        .map((p) => p.read(db.playlistsToMerge.destinationPlaylistId))
        .get();
    return values;
  }

  Future<List<PlaylistToMerge>> getPlaylistsToMergeByDestinationId(String destinationPlaylistId) {
    return (select(
      playlistsToMerge,
    )..where((tbl) => tbl.destinationPlaylistId.equals(destinationPlaylistId))).get();
  }

  Future<void> deleteMergedPlaylist(String playlistId) async {
    await (delete(playlistsToMerge)..where((p) => p.destinationPlaylistId.equals(playlistId))).go();
  }

  Future<void> updateMergedPlaylist(
    String destinationPlaylistId,
    List<String> sourcePlaylistsId, {
    bool deleteBeforeInsert = true,
  }) async {
    final destinationPlaylist = await db.playlistsDao.getPlaylistsByIdList([destinationPlaylistId]);
    if (destinationPlaylist.isNotEmpty) {
      final sourcesPlaylists = await db.playlistsDao.getPlaylistsByIdList(sourcePlaylistsId);
      if (sourcesPlaylists.isNotEmpty) {
        await batch((batch) {
          // import sources
          if (deleteBeforeInsert) {
            batch.deleteWhere(
              playlistsToMerge,
              (_) => playlistsToMerge.destinationPlaylistId.equals(destinationPlaylistId),
            );
          }
          batch.insertAllOnConflictUpdate(
            playlistsToMerge,
            sourcesPlaylists
                .map(
                  (e) => PlaylistsToMergeCompanion(
                    destinationPlaylistId: Value(destinationPlaylistId),
                    sourcePlaylistId: Value(e.playlistId),
                  ),
                )
                .toList(),
          );
        });
      }
    }
  }
}
