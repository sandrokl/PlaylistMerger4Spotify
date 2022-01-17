import 'package:drift/drift.dart';
import 'package:playlistmerger_4_spotify/database/database.dart';
import 'package:playlistmerger_4_spotify/database/models/playlists.dart';

part 'playlists_dao.g.dart';

@DriftAccessor(tables: [Playlists])
class PlaylistsDao extends DatabaseAccessor<AppDatabase>
    with _$PlaylistsDaoMixin {
  PlaylistsDao(AppDatabase db) : super(db);

  Future<List<Playlist>> getAllUserPlaylists() {
    return select(playlists).get();
  }
}
