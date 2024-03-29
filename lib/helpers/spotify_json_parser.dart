import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';

Playlist playlistFromSpotifyJson(Map<String, dynamic> json) {
  return Playlist(
      playlistId: json["id"],
      name: json["name"],
      ownerId: json["owner"]["id"],
      tracksUrl: json["tracks"]["href"],
      playUrl: json["external_urls"]["spotify"],
      isValidated: true);
}

Track trackFromSpotifyJson(int jobId, String playlistId, Map<String, dynamic> json) {
  var allArtists = (json["track"]["artists"] as List<dynamic>).cast<Map<String, dynamic>>();
  var artistsList = allArtists.map((artist) => _cleanStringForComparison(artist["name"].toString())).toList()..sort();
  var artistsNames = artistsList.join("~");

  return Track(
    jobId: jobId,
    playlistId: playlistId,
    trackId: json["track"]["id"],
    name: _cleanStringForComparison(json["track"]["name"].toString()),
    trackArtists: artistsNames,
    trackUri: json["track"]["uri"],
    durationMs: json["track"]["duration_ms"],
    addedAt: DateTime.parse(json["added_at"]),
  );
}

_cleanStringForComparison(String input) {
  return input.trim().toLowerCase();
}
