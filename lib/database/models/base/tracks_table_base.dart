import 'package:drift/drift.dart';

abstract class TracksTableBase extends Table {
  TextColumn get playlistId => text()();
  TextColumn get trackId => text()();
  TextColumn get name => text()();
  TextColumn get trackArtists => text()();
  TextColumn get trackUri => text()();
  IntColumn get durationMs => integer()();

  @override
  Set<Column> get primaryKey => {playlistId, trackId};
}
