// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotify_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SpotifyUserStore on _SpotifyUserStoreBase, Store {
  Computed<SpotifyUser?>? _$userComputed;

  @override
  SpotifyUser? get user =>
      (_$userComputed ??= Computed<SpotifyUser?>(() => super.user,
              name: '_SpotifyUserStoreBase.user'))
          .value;

  final _$_userAtom = Atom(name: '_SpotifyUserStoreBase._user');

  @override
  SpotifyUser? get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(SpotifyUser? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  final _$_SpotifyUserStoreBaseActionController =
      ActionController(name: '_SpotifyUserStoreBase');

  @override
  void setUser(SpotifyUser user) {
    final _$actionInfo = _$_SpotifyUserStoreBaseActionController.startAction(
        name: '_SpotifyUserStoreBase.setUser');
    try {
      return super.setUser(user);
    } finally {
      _$_SpotifyUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
