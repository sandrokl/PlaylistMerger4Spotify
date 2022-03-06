import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/models/playlists.dart';

@DataClassName("PlaylistToIgnore")
class PlaylistsToIgnore extends Table {
  TextColumn get destinationPlaylistId =>
      text().references(Playlists, #playlistId, onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();
  TextColumn get sourcePlaylistId => text()();
  TextColumn get sourceName => text()();
  TextColumn get sourcePictureUrl => text()();

  @override
  Set<Column> get primaryKey => {destinationPlaylistId, sourcePlaylistId};
}
