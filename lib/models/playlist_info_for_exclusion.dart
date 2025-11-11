import 'package:playlistmerger4spotify/database/database.dart';

class PlaylistInfoForExclusion extends PlaylistToIgnore {
  final String playlistCoverArt;
  final int totalTracks;

  PlaylistInfoForExclusion({
    required super.destinationPlaylistId,
    required super.playlistId,
    required super.name,
    required super.ownerId,
    required super.ownerName,
    required super.openUrl,
    required this.playlistCoverArt,
    required this.totalTracks,
  });
}
