import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/models/playlists.dart';

enum TriggeredBy { user, schedule }

class MergingResults extends Table {
  TextColumn get playlistId =>
      text().references(Playlists, #playlistId, onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();
  DateTimeColumn get runDate => dateTime()();
  BoolColumn get successed => boolean()();
  IntColumn get durationMs => integer()();
  IntColumn get triggeredBy => intEnum<TriggeredBy>()();
  IntColumn get tracksAdded => integer().nullable()();
  IntColumn get tracksRemoved => integer().nullable()();

  @override
  Set<Column>? get primaryKey => {playlistId, runDate};
}
