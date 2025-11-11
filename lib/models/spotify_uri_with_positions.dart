import 'package:playlistmerger4spotify/models/spotify_uri.dart';

class SpotifyUriWithPositions extends SpotifyUri {
  List<int> positions;

  SpotifyUriWithPositions(super.uri, this.positions);

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    data['positions'] = positions;
    return data;
  }
}
