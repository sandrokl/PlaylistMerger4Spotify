import 'package:playlistmerger4spotify/database/database.dart';

Playlist playlistFromSpotifyJson(Map<String, dynamic> json) {
  return Playlist(
      playlistId: json["id"],
      name: json["name"],
      ownerId: json["owner"]["id"],
      tracksUrl: json["tracks"]["href"],
      playUrl: json["external_urls"]["spotify"],
      isValidated: true);
}
