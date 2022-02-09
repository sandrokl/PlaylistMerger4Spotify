import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/models/track.dart';
import 'package:playlistmerger4spotify/database/models/tracks_table_base.dart';

@UseRowClass(Track)
class TracksToAdd extends TracksTableBase {}
