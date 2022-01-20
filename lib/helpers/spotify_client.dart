import 'dart:convert';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/models/spotify_user.dart';
import 'package:playlistmerger4spotify/spotify_secrets.dart' as secrets;
import 'package:playlistmerger4spotify/helpers/spotify_json_parser.dart';

class SpotifyClient {
  final _apiUrlBase = "https://api.spotify.com/v1";

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
        scopes: secrets.spotify_scopes);
  }

  Future<SpotifyUser> getUserFromSession() async {
    var httpResponse = await _httpHelper.get("$_apiUrlBase/me");
    return SpotifyUser.fromJson(jsonDecode(httpResponse.body));
  }

  Future<List<Playlist>> getUserPlaylists() async {
    var page = 0;
    var pageSize = 20;
    String? next = "";

    List<Playlist> list = [];

    do {
      var offset = (page * pageSize);
      var httpResponse = await _httpHelper
          .get("$_apiUrlBase/me/playlists?offset=$offset&limit=$pageSize");

      var jsonListPlaylists = jsonDecode(httpResponse.body);
      for (var jsonPlaylist in jsonListPlaylists["items"]) {
        list.add(playlistFromSpotifyJson(jsonPlaylist));
      }

      next = jsonListPlaylists["next"];
      page++;
    } while (next != null);

    return list;
  }
}
