import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/playlists_to_merge.dart';

part 'playlists_to_merge_dao.g.dart';

@DriftAccessor(tables: [PlaylistsToMerge])
class PlaylistsToMergeDao extends DatabaseAccessor<AppDatabase>
    with _$PlaylistsToMergeDaoMixin {
  PlaylistsToMergeDao(AppDatabase db) : super(db);

  Future<List<PlaylistToMerge>> getPlaylistsToMergeByDestinationId(
      String destinationPlaylistId) {
    return (select(playlistsToMerge)
          ..where(
              (tbl) => tbl.destinationPlaylistId.equals(destinationPlaylistId)))
        .get();
  }

  Future<void> deleteMergedPlaylist(String playlistId) async {
    await (delete(playlistsToMerge)
          ..where((p) => p.destinationPlaylistId.equals(playlistId)))
        .go();
  }
}
