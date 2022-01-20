import 'package:drift/drift.dart';

class Playlists extends Table {
  TextColumn get playlistId => text()();
  TextColumn get name => text()();
  TextColumn get ownerId => text()();
  TextColumn get tracksUrl => text()();
  TextColumn get playUrl => text()();
  BoolColumn get isValidated => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {playlistId};
}
