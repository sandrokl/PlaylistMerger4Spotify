import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/models/playlists.dart';

@DataClassName("PlaylistToIgnore")
class PlaylistsToIgnore extends Table {
  TextColumn get destinationPlaylistId =>
      text().references(Playlists, #playlistId, onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();
  TextColumn get playlistId => text()();
  TextColumn get name => text()();
  TextColumn get ownerId => text()();
  TextColumn get ownerName => text()();
  TextColumn get openUrl => text()();

  @override
  Set<Column> get primaryKey => {destinationPlaylistId, playlistId};
}
