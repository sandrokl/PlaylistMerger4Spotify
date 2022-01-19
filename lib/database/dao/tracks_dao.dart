import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/tracks.dart';

part 'tracks_dao.g.dart';

@DriftAccessor(tables: [Tracks])
class TracksDao extends DatabaseAccessor<AppDatabase> with _$TracksDaoMixin {
  TracksDao(AppDatabase db) : super(db);
}
