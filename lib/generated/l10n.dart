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

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
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

  /// `'s merging definition? This will not delete the playlist in Spotify.`
  String get areYouSureYouWishToDelete_end {
    return Intl.message(
      '\'s merging definition? This will not delete the playlist in Spotify.',
      name: 'areYouSureYouWishToDelete_end',
      desc: '',
      args: [],
    );
  }

  /// `Saving...`
  String get saving_threedots {
    return Intl.message(
      'Saving...',
      name: 'saving_threedots',
      desc: '',
      args: [],
    );
  }

  /// `Open in Spotify`
  String get openInSpotify {
    return Intl.message(
      'Open in Spotify',
      name: 'openInSpotify',
      desc: '',
      args: [],
    );
  }

  /// `Modify this merging definition`
  String get modifyThisMergingRule {
    return Intl.message(
      'Modify this merging definition',
      name: 'modifyThisMergingRule',
      desc: '',
      args: [],
    );
  }

  /// `-- Select a playlist -- `
  String get selectAPlaylist {
    return Intl.message(
      '-- Select a playlist -- ',
      name: 'selectAPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Destination playlist`
  String get destinationPlaylist {
    return Intl.message(
      'Destination playlist',
      name: 'destinationPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Source playlists`
  String get sourcePlaylists {
    return Intl.message(
      'Source playlists',
      name: 'sourcePlaylists',
      desc: '',
      args: [],
    );
  }

  /// `DISMISS`
  String get dismiss {
    return Intl.message(
      'DISMISS',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Do not show again`
  String get doNotShowAgain {
    return Intl.message(
      'Do not show again',
      name: 'doNotShowAgain',
      desc: '',
      args: [],
    );
  }

  /// `Changes saved. You can run the merging again to update it in Spotify.`
  String get changesSaved {
    return Intl.message(
      'Changes saved. You can run the merging again to update it in Spotify.',
      name: 'changesSaved',
      desc: '',
      args: [],
    );
  }

  /// `Delete this merging definition`
  String get deleteThisMergingRule {
    return Intl.message(
      'Delete this merging definition',
      name: 'deleteThisMergingRule',
      desc: '',
      args: [],
    );
  }

  /// `CREATE IT`
  String get createIt {
    return Intl.message(
      'CREATE IT',
      name: 'createIt',
      desc: '',
      args: [],
    );
  }

  /// `New playlist's name`
  String get nameOfThePlaylist {
    return Intl.message(
      'New playlist\'s name',
      name: 'nameOfThePlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Create new playlist`
  String get createNewPlaylist {
    return Intl.message(
      'Create new playlist',
      name: 'createNewPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the playlist name`
  String get pleaseEnterThePlaylistName {
    return Intl.message(
      'Please enter the playlist name',
      name: 'pleaseEnterThePlaylistName',
      desc: '',
      args: [],
    );
  }

  /// `Playlist created with PlaylistMerger 4 Spotify`
  String get playlistCreatedWithPlaylistmerger4Spotify {
    return Intl.message(
      'Playlist created with PlaylistMerger 4 Spotify',
      name: 'playlistCreatedWithPlaylistmerger4Spotify',
      desc: '',
      args: [],
    );
  }

  /// `Import merging definitions`
  String get importMergingDefinitions {
    return Intl.message(
      'Import merging definitions',
      name: 'importMergingDefinitions',
      desc: '',
      args: [],
    );
  }

  /// `Export merging definitions`
  String get exportMergingDefinitions {
    return Intl.message(
      'Export merging definitions',
      name: 'exportMergingDefinitions',
      desc: '',
      args: [],
    );
  }

  /// `Settings...`
  String get settings {
    return Intl.message(
      'Settings...',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Update this in Spotify`
  String get updateThisInSpotify {
    return Intl.message(
      'Update this in Spotify',
      name: 'updateThisInSpotify',
      desc: '',
      args: [],
    );
  }

  /// `Merging definitions imported successfully, as much as possible, respecting your current playlists.`
  String get mergingDefinitionsImportedSuccessfully {
    return Intl.message(
      'Merging definitions imported successfully, as much as possible, respecting your current playlists.',
      name: 'mergingDefinitionsImportedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, one {An update to your playlist is being made in Spotify. We'll let you know when it's finished. Do not launch any new update until then.} other {An update to your playlists is being made in Spotify. We'll let you know when it's finished. Do not launch any new update until then.}}`
  String anUpdateToYourPlaylistIsBeingMadeInSpotify(int howMany) {
    return Intl.plural(
      howMany,
      one:
          'An update to your playlist is being made in Spotify. We\'ll let you know when it\'s finished. Do not launch any new update until then.',
      other:
          'An update to your playlists is being made in Spotify. We\'ll let you know when it\'s finished. Do not launch any new update until then.',
      name: 'anUpdateToYourPlaylistIsBeingMadeInSpotify',
      desc: '',
      args: [howMany],
    );
  }

  /// `<b>Success!</b>`
  String get notificationSuccessTitle {
    return Intl.message(
      '<b>Success!</b>',
      name: 'notificationSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `<b>Failure</b>`
  String get notificationFailureTitle {
    return Intl.message(
      '<b>Failure</b>',
      name: 'notificationFailureTitle',
      desc: '',
      args: [],
    );
  }

  /// `&#128516 Your merged playlist <em>{name}</em> has been updated successfully.`
  String notificationPlaylistUpdatedSuccessfully(String name) {
    return Intl.message(
      '&#128516 Your merged playlist <em>$name</em> has been updated successfully.',
      name: 'notificationPlaylistUpdatedSuccessfully',
      desc: '',
      args: [name],
    );
  }

  /// `&#128516 All your merged playlists have been updated successfully.`
  String get notificationAllPlaylistsUpdatedSuccessfully {
    return Intl.message(
      '&#128516 All your merged playlists have been updated successfully.',
      name: 'notificationAllPlaylistsUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `&#128577 There was an error trying to update your playlists. Please try again later.`
  String get notificationMergingFailed {
    return Intl.message(
      '&#128577 There was an error trying to update your playlists. Please try again later.',
      name: 'notificationMergingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Results of the playlists updates requests`
  String get channelNameMergingResults {
    return Intl.message(
      'Results of the playlists updates requests',
      name: 'channelNameMergingResults',
      desc: '',
      args: [],
    );
  }

  /// `<b>Busy</b>`
  String get busyTitle {
    return Intl.message(
      '<b>Busy</b>',
      name: 'busyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please wait the current update to finish before starting a new one.`
  String get busyMessage {
    return Intl.message(
      'Please wait the current update to finish before starting a new one.',
      name: 'busyMessage',
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
