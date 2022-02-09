import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/database/models/base/tracks_table_base.dart';

@UseRowClass(Track)
class NewAllTracks extends TracksTableBase {}
