import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/base/tracks_table_base.dart';

@UseRowClass(Track)
class TracksToExclude extends TracksTableBase {
  // in this table we may receive tracks from playlists the user doesn't follow
  // so the foreign key in this column must be removed
  @override
  TextColumn get playlistId => text()();
}
