import 'package:playlistmerger4spotify/database/database.dart';

class PlaylistInfoForExclusion extends PlaylistToIgnore {
  final String playlistCoverArt;
  final int totalTracks;

  PlaylistInfoForExclusion(
      {required String destinationPlaylistId,
      required String playlistId,
      required String name,
      required String ownerId,
      required String ownerName,
      required String openUrl,
      required this.playlistCoverArt,
      required this.totalTracks})
      : super(
            destinationPlaylistId: destinationPlaylistId,
            playlistId: playlistId,
            name: name,
            ownerId: ownerId,
            ownerName: ownerName,
            openUrl: openUrl);
}
