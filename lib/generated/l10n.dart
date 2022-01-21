// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PlaylistMerger 4 Spotify`
  String get appTitle {
    return Intl.message(
      'PlaylistMerger 4 Spotify',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Spotify user`
  String get spotifyUser {
    return Intl.message(
      'Spotify user',
      name: 'spotifyUser',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Please login to Spotify`
  String get pleaseLoginToSpotify {
    return Intl.message(
      'Please login to Spotify',
      name: 'pleaseLoginToSpotify',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `To begin, we will open the Spotify login page next`
  String get we_will_open_login {
    return Intl.message(
      'To begin, we will open the Spotify login page next',
      name: 'we_will_open_login',
      desc: '',
      args: [],
    );
  }

  /// `When asked to choose your DESTINATION PLAYLIST, make sure to choose a playlist that doesn't already contain your music.\nIt will be completely erased and replaced with the new merging results.`
  String get makeSureToChooseAPlaylistYouDontDirectlyAdd {
    return Intl.message(
      'When asked to choose your DESTINATION PLAYLIST, make sure to choose a playlist that doesn\'t already contain your music.\nIt will be completely erased and replaced with the new merging results.',
      name: 'makeSureToChooseAPlaylistYouDontDirectlyAdd',
      desc: '',
      args: [],
    );
  }

  /// `Careful!`
  String get carefulexclamation {
    return Intl.message(
      'Careful!',
      name: 'carefulexclamation',
      desc: '',
      args: [],
    );
  }

  /// `Nothing here for now. Start creating your merged playlists using the button below.`
  String get nothingHereForNow {
    return Intl.message(
      'Nothing here for now. Start creating your merged playlists using the button below.',
      name: 'nothingHereForNow',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `DELETE`
  String get delete {
    return Intl.message(
      'DELETE',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get cancel {
    return Intl.message(
      'CANCEL',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete `
  String get areYouSureYouWishToDelete_start {
    return Intl.message(
      'Are you sure you want to delete ',
      name: 'areYouSureYouWishToDelete_start',
      desc: '',
      args: [],
    );
  }

  /// `'s merging rule? This will not delete the playlist in Spotify.`
  String get areYouSureYouWishToDelete_end {
    return Intl.message(
      '\'s merging rule? This will not delete the playlist in Spotify.',
      name: 'areYouSureYouWishToDelete_end',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
