import 'package:flutter/material.dart';
import 'package:playlistmerger_4_spotify/models/spotify_user.dart';

class SpotifyUserStore extends ChangeNotifier {
  SpotifyUser? _user;
  SpotifyUser? get user => _user;

  void setUser(SpotifyUser user) {
    _user = user;
    notifyListeners();
  }
}
