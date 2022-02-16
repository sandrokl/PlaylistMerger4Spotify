import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/models/playlists.dart';

abstract class TracksTableBase extends Table {
  IntColumn get jobId => integer()();
  TextColumn get playlistId =>
      text().references(Playlists, #playlistId, onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();
  TextColumn get trackId => text()();
  TextColumn get name => text()();
  TextColumn get trackArtists => text()();
  TextColumn get trackUri => text()();
  IntColumn get durationMs => integer()();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {playlistId, trackId};
}
