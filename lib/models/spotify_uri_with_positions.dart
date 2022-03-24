import 'package:playlistmerger4spotify/models/spotify_uri.dart';

class SpotifyUriWithPositions extends SpotifyUri {
  List<int> positions;

  SpotifyUriWithPositions(String uri, this.positions) : super(uri);

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    data['positions'] = positions;
    return data;
  }
}
