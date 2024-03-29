// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/helpers/spotify_json_parser.dart';
import 'package:playlistmerger4spotify/models/playlist_info_for_exclusion.dart';
import 'package:playlistmerger4spotify/models/spotify_uri.dart';
import 'package:playlistmerger4spotify/models/spotify_uri_with_positions.dart';
import 'package:playlistmerger4spotify/models/spotify_user.dart';
import 'package:playlistmerger4spotify/spotify_secrets.dart' as secrets;

class SpotifyClient {
  final _apiUrlBase = "https://api.spotify.com/v1";
  final _pageSize = 50;
  final _statusCodeTooManyRequests = 429;
  final _retryDelay = const Duration(seconds: 15);

  late OAuth2Helper _httpHelper;

  static final SpotifyClient _singleton = SpotifyClient._internal();
  factory SpotifyClient() => _singleton;
  SpotifyClient._internal() {
    _httpHelper = OAuth2Helper(
        SpotifyOAuth2Client(
          customUriScheme: secrets.spotify_customUriScheme,
          redirectUri: secrets.spotify_redirectUri,
        ),
        grantType: OAuth2Helper.authorizationCode,
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
    String? next = "";

    List<Playlist> list = [];

    do {
      var offset = (page * _pageSize);
      var httpResponse = await _httpHelper.get("$_apiUrlBase/me/playlists?offset=$offset&limit=$_pageSize");

      // if Spotify returns "too many requests", wait 15s to retry
      if (httpResponse.statusCode == _statusCodeTooManyRequests) {
        await Future.delayed(_retryDelay);
        continue;
      }

      var jsonListPlaylists = jsonDecode(httpResponse.body);
      for (var jsonPlaylist in jsonListPlaylists["items"]) {
        list.add(playlistFromSpotifyJson(jsonPlaylist));
      }

      next = jsonListPlaylists["next"];
      page++;
    } while (next != null);

    return list;
  }

  Future<Playlist> createNewPlaylist(BuildContext context, String userId, String playlistName) async {
    var httpResponse = await _httpHelper.post("$_apiUrlBase/users/$userId/playlists",
        body: jsonEncode(<String, dynamic>{
          "name": playlistName,
          "description": S.of(context).playlistCreatedWithPlaylistmerger4Spotify,
          "public": false,
          "collaborative": false
        }));
    var responseJson = jsonDecode(httpResponse.body);
    return playlistFromSpotifyJson(responseJson);
  }

  Stream<Track> getTracksFromPlaylist(String playlistId) async* {
    var page = 0;
    String? next = "";

    do {
      var offset = (page * _pageSize);
      var httpResponse = await _httpHelper.get(
        "$_apiUrlBase/playlists/$playlistId/tracks?fields=items(added_at,track(id,name,uri,duration_ms,artists(name))),previous,next&limit=$_pageSize&offset=$offset",
      );

      // if Spotify returns "too many requests", wait 15s to retry
      if (httpResponse.statusCode == _statusCodeTooManyRequests) {
        await Future.delayed(_retryDelay);
        continue;
      } else if (httpResponse.statusCode == 404) {
        // an error in the spotify API sometimes returns "Not found" on playlists that exist.
        // we will continue with the other playlists instead of exiting in error.
        break;
      }

      var jsonListTracks = jsonDecode(httpResponse.body);
      for (var jsonTrack in jsonListTracks["items"]) {
        yield trackFromSpotifyJson(-1, playlistId, jsonTrack);
      }

      next = jsonListTracks["next"];
      page++;
    } while (next != null);
  }

  Stream<String> getUrisFromPlaylist(String playlistId) async* {
    var page = 0;
    String? next = "";

    do {
      var offset = (page * _pageSize);
      var httpResponse = await _httpHelper.get(
        "$_apiUrlBase/playlists/$playlistId/tracks?fields=items(track(uri)),previous,next&limit=$_pageSize&offset=$offset",
      );

      // if Spotify returns "too many requests", wait 15s to retry
      if (httpResponse.statusCode == _statusCodeTooManyRequests) {
        await Future.delayed(_retryDelay);
        continue;
      } else if (httpResponse.statusCode == 404) {
        // an error in the spotify API sometimes returns "Not found" on playlists that exist.
        // we will continue with the other playlists instead of exiting in error.
        break;
      }

      var jsonListTracks = jsonDecode(httpResponse.body);
      for (var jsonTrack in jsonListTracks["items"]) {
        yield jsonTrack["track"]["uri"].toString();
      }

      next = jsonListTracks["next"];
      page++;
    } while (next != null);
  }

  Future<void> insertTracksInPlaylist(String playlistId, List<Track> tracksToAdd) async {
    var slices = (tracksToAdd.length / _pageSize).ceil();
    var i = 0;
    do {
      var tracks = i == (slices - 1)
          ? tracksToAdd.sublist(i * _pageSize)
          : tracksToAdd.sublist(i * _pageSize, (i * _pageSize) + _pageSize);

      var toInsert = <String, dynamic>{};
      toInsert["uris"] = tracks.map((t) => t.trackUri).toList();

      var httpResponse = await _httpHelper.post(
        "$_apiUrlBase/playlists/$playlistId/tracks",
        body: jsonEncode(toInsert),
      );

      if (httpResponse.statusCode == _statusCodeTooManyRequests) {
        await Future.delayed(_retryDelay);
        continue;
      }

      i++;
    } while (i < slices);
  }

  Future<void> removeTracksByIdInPlaylist(String playlistId, List<Track> tracksToRemove) async {
    var slices = (tracksToRemove.length / _pageSize).ceil();
    var i = 0;
    do {
      var tracks = i == (slices - 1)
          ? tracksToRemove.sublist(i * _pageSize)
          : tracksToRemove.sublist(i * _pageSize, (i * _pageSize) + _pageSize);

      var toDelete = <String, dynamic>{};
      var listUris = (tracks.map((t) => SpotifyUri(t.trackUri).toMap())).toList();
      toDelete["tracks"] = listUris;
      var accessToken = (await _httpHelper.getToken())!.accessToken!;

      var req = http.Request("DELETE", Uri.parse("$_apiUrlBase/playlists/$playlistId/tracks"));
      req.headers["Accept"] = "application/json";
      req.headers["Content-Type"] = "application/json";
      req.headers["Authorization"] = "Bearer $accessToken";
      req.body = jsonEncode(toDelete);
      var httpResponse = await req.send();

      if (httpResponse.statusCode == _statusCodeTooManyRequests) {
        await Future.delayed(_retryDelay);
        continue;
      }

      i++;
    } while (i < slices);
  }

  Future<void> removeTracksByIdAndPositionInPlaylist(
      String playlistId, List<SpotifyUriWithPositions> tracksToRemove) async {
    var slices = (tracksToRemove.length / _pageSize).ceil();
    var i = 0;
    do {
      var tracks = i == (slices - 1)
          ? tracksToRemove.sublist(i * _pageSize)
          : tracksToRemove.sublist(i * _pageSize, (i * _pageSize) + _pageSize);

      var toDelete = <String, dynamic>{};
      toDelete["tracks"] = tracks.map((e) => e.toMap()).toList();
      var accessToken = (await _httpHelper.getToken())!.accessToken!;

      var req = http.Request("DELETE", Uri.parse("$_apiUrlBase/playlists/$playlistId/tracks"));
      req.headers["Accept"] = "application/json";
      req.headers["Content-Type"] = "application/json";
      req.headers["Authorization"] = "Bearer $accessToken";
      req.body = jsonEncode(toDelete);
      var httpResponse = await req.send();

      if (httpResponse.statusCode == _statusCodeTooManyRequests) {
        await Future.delayed(_retryDelay);
        continue;
      }

      i++;
    } while (i < slices);
  }

  Future<PlaylistInfoForExclusion?> getPlaylistInfo(String id) async {
    var response =
        await _httpHelper.get("$_apiUrlBase/playlists/$id?fields=id,name,external_urls,images,owner,tracks(total)");

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var allImages = (json["images"] as List<dynamic>).cast<Map<String, dynamic>>();

      return PlaylistInfoForExclusion(
        destinationPlaylistId: '',
        playlistId: json['id'],
        name: json['name'],
        ownerId: json['owner']['id'],
        ownerName: json['owner']['display_name'],
        openUrl: json['external_urls']['spotify'],
        playlistCoverArt: allImages[allImages.length - 1]['url'],
        totalTracks: json['tracks']['total'],
      );
    }
    return null;
  }
}
