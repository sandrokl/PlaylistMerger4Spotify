import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:http/http.dart' as http;
import '../spotify_secrets.dart' as secrets;

class SpotifyClient {
  late OAuth2Helper _httpHelper;

  static final SpotifyClient _singleton = SpotifyClient._internal();

  factory SpotifyClient() => _singleton;

  SpotifyClient._internal() {
    _httpHelper = OAuth2Helper(
        SpotifyOAuth2Client(
          customUriScheme: secrets.spotify_customUriScheme,
          redirectUri: secrets.spotify_redirectUri,
        ),
        grantType: OAuth2Helper.AUTHORIZATION_CODE,
        clientId: secrets.spotify_clientId,
        clientSecret: secrets.spotify_clientSecret,
        scopes: secrest.spotify_scopes);
  }

  Future<http.Response> get(String url) async {
    return await _httpHelper.get(url);
  }
}
