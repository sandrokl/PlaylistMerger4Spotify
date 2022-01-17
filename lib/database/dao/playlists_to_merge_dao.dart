import 'package:drift/drift.dart';
import 'package:playlistmerger_4_spotify/database/database.dart';
import 'package:playlistmerger_4_spotify/database/models/playlists_to_merge.dart';

part 'playlists_to_merge_dao.g.dart';

@DriftAccessor(tables: [PlaylistsToMerge])
class PlaylistsToMergeDao extends DatabaseAccessor<AppDatabase>
    with _$PlaylistsToMergeDaoMixin {
  PlaylistsToMergeDao(AppDatabase db) : super(db);

  Future<List<PlaylistToMerge>> getAllPlaylistsToMerge() {
    return select(playlistsToMerge).get();
  }
}
