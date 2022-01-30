// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle":
            MessageLookupByLibrary.simpleMessage("PlaylistMerger 4 Spotify"),
        "areYouSureYouWishToDelete_end": MessageLookupByLibrary.simpleMessage(
            "\'s merging rule? This will not delete the playlist in Spotify."),
        "areYouSureYouWishToDelete_start": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete "),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "carefulexclamation": MessageLookupByLibrary.simpleMessage("Careful!"),
        "changesSaved": MessageLookupByLibrary.simpleMessage(
            "Changes saved. You can run the merging again to update it in Spotify."),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "createIt": MessageLookupByLibrary.simpleMessage("CREATE IT"),
        "createNewPlaylist":
            MessageLookupByLibrary.simpleMessage("Create new playlist"),
        "delete": MessageLookupByLibrary.simpleMessage("DELETE"),
        "deleteThisMergingRule":
            MessageLookupByLibrary.simpleMessage("Delete this merging rule"),
        "destinationPlaylist":
            MessageLookupByLibrary.simpleMessage("Destination playlist"),
        "dismiss": MessageLookupByLibrary.simpleMessage("DISMISS"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Do not show again"),
        "makeSureToChooseAPlaylistYouDontDirectlyAdd":
            MessageLookupByLibrary.simpleMessage(
                "When asked to choose your DESTINATION PLAYLIST, make sure to choose a playlist that doesn\'t already contain your music.\nIt will be completely erased and replaced with the new merging results."),
        "modifyThisMergingRule":
            MessageLookupByLibrary.simpleMessage("Modify this merging rule"),
        "nameOfThePlaylist":
            MessageLookupByLibrary.simpleMessage("New playlist\'s name"),
        "nothingHereForNow": MessageLookupByLibrary.simpleMessage(
            "Nothing here for now. Start creating your merged playlists using the button below."),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "openInSpotify":
            MessageLookupByLibrary.simpleMessage("Open in Spotify"),
        "playlistCreatedWithPlaylistmerger4Spotify":
            MessageLookupByLibrary.simpleMessage(
                "Playlist created with PlaylistMerger 4 Spotify"),
        "pleaseEnterThePlaylistName": MessageLookupByLibrary.simpleMessage(
            "Please enter the playlist name"),
        "pleaseLoginToSpotify":
            MessageLookupByLibrary.simpleMessage("Please login to Spotify"),
        "saving_threedots": MessageLookupByLibrary.simpleMessage("Saving..."),
        "selectAPlaylist":
            MessageLookupByLibrary.simpleMessage("-- Select a playlist -- "),
        "sourcePlaylists":
            MessageLookupByLibrary.simpleMessage("Source playlists"),
        "spotifyUser": MessageLookupByLibrary.simpleMessage("Spotify user"),
        "we_will_open_login": MessageLookupByLibrary.simpleMessage(
            "To begin, we will open the Spotify login page next"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome")
      };
}
