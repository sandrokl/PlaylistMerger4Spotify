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
}
