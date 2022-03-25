import 'package:playlistmerger4spotify/helpers/spotify_client.dart';
import 'package:playlistmerger4spotify/models/spotify_uri_with_positions.dart';

class DeduplicatorHelper {
  static final DeduplicatorHelper _instance = DeduplicatorHelper._internal();
  factory DeduplicatorHelper() => _instance;
  DeduplicatorHelper._internal();

  final _spotifyClient = SpotifyClient();

  Future<int> deduplicateTracks(String playlistId) async {
    var allIds = <String>[];
    await for (var id in _spotifyClient.getUrisFromPlaylist(playlistId)) {
      allIds.add(id);
    }

    final seenIds = <String>[];
    final duplicates = <SpotifyUriWithPositions>[];

    allIds.asMap().forEach((i, value) {
      if (seenIds.any((e) => e == value)) {
        duplicates.add(SpotifyUriWithPositions(value, [i]));
      } else {
        seenIds.add(value);
      }
    });

    if (duplicates.isNotEmpty) {
      await _spotifyClient.removeTracksByIdAndPositionInPlaylist(playlistId, duplicates.reversed.toList());
    }

    return duplicates.length;
  }
}
