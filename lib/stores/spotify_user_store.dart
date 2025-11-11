import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/models/spotify_user.dart';

class SpotifyUserStore with ChangeNotifier {
  SpotifyUser? _user;
  SpotifyUser? get user => _user;

  void setUser(SpotifyUser user) {
    _user = user;
    notifyListeners();
  }
}
