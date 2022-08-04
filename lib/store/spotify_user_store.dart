// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:playlistmerger4spotify/models/spotify_user.dart';

part 'spotify_user_store.g.dart';

class SpotifyUserStore = _SpotifyUserStoreBase with _$SpotifyUserStore;

abstract class _SpotifyUserStoreBase with Store {
  @observable
  SpotifyUser? _user;

  @computed
  SpotifyUser? get user => _user;

  @action
  void setUser(SpotifyUser user) {
    _user = user;
  }
}
