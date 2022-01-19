import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/models/playlists.dart';

@DataClassName("PlaylistToMerge")
class PlaylistsToMerge extends Table {
  TextColumn get destinationPlaylistId =>
      text().references(Playlists, #playlistId,
          onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();
  TextColumn get sourcePlaylistId => text().references(Playlists, #playlistId,
      onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {destinationPlaylistId, sourcePlaylistId};
}
