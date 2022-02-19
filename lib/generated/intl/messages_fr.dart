// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: 'La mise à jour de votre playlist est lancée sur Spotify. On vous avisera quand ce sera terminé.', other: 'Les mises à jour de vos playlists sont lancées sur Spotify. On vous avisera quand ce sera terminé.')}";

  static String m1(name) =>
      "&#128516 Votre playlist fusionée <em>${name}</em> a été mise à jour.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "anUpdateToYourPlaylistIsBeingMadeInSpotify": m0,
        "appTitle":
            MessageLookupByLibrary.simpleMessage("PlaylistMerger 4 Spotify"),
        "areYouSureYouWishToDelete_end": MessageLookupByLibrary.simpleMessage(
            "? Cela ne supprimera pas votre playlist sur Spotify."),
        "areYouSureYouWishToDelete_start": MessageLookupByLibrary.simpleMessage(
            "Êtes vous certain de vouloir supprimer la definition de fusion pour "),
        "cancel": MessageLookupByLibrary.simpleMessage("canceller"),
        "carefulexclamation":
            MessageLookupByLibrary.simpleMessage("Attention!"),
        "changesSaved": MessageLookupByLibrary.simpleMessage(
            "Changements sauvegardés. Vous pouvez éxécuter la mise à jour à nouveau pour rafraîchir la playlist sur Spotify."),
        "channelNameMergingResults": MessageLookupByLibrary.simpleMessage(
            "Résultat des mises à jour des playlists"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmer"),
        "createIt": MessageLookupByLibrary.simpleMessage("CRÉER"),
        "createNewPlaylist":
            MessageLookupByLibrary.simpleMessage("Créer une nouvelle playlist"),
        "delete": MessageLookupByLibrary.simpleMessage("SUPPRIMER"),
        "deleteThisMergingRule":
            MessageLookupByLibrary.simpleMessage("Supprimer cette definition"),
        "destinationPlaylist":
            MessageLookupByLibrary.simpleMessage("Playlist de destination"),
        "dismiss": MessageLookupByLibrary.simpleMessage("FERMER"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Ne plus afficher"),
        "exportMergingDefinitions":
            MessageLookupByLibrary.simpleMessage("Exporter les définitions"),
        "importMergingDefinitions":
            MessageLookupByLibrary.simpleMessage("Importer les définitions"),
        "makeSureToChooseAPlaylistYouDontDirectlyAdd":
            MessageLookupByLibrary.simpleMessage(
                "Au moment de choisir la PLAYLIST DE DESTINATION, veuillez vous assurer de ne pas choisir une playlist qui contient vos chansons.\nCelle-ci sera effacée et remplacée avec les résultats de la fusion."),
        "mergingDefinitionsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Définition des fusions importée avec succès. Les playlists absentes de votre bibliothèque actuelle n\'ont pas été importées."),
        "modifyThisMergingRule": MessageLookupByLibrary.simpleMessage(
            "Modifier la définition de fusion"),
        "nameOfThePlaylist":
            MessageLookupByLibrary.simpleMessage("Nom de la nouvelle playlist"),
        "nothingHereForNow": MessageLookupByLibrary.simpleMessage(
            "Rien ici pour l\'instant. Commencez à créer vos playlists fusionnées en utilisant le bouton ci-dessous."),
        "notificationAllPlaylistsUpdatedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "&#128516 Toutes vos playlists ont bien été mises à jour."),
        "notificationFailureTitle":
            MessageLookupByLibrary.simpleMessage("<b>Échec</b>"),
        "notificationInProgressChannelName":
            MessageLookupByLibrary.simpleMessage("Mise à jour en progrès"),
        "notificationInProgressMessage":
            MessageLookupByLibrary.simpleMessage("Mise à jour de playlist..."),
        "notificationMergingFailed": MessageLookupByLibrary.simpleMessage(
            "&#128577 Une erreur s\'est passée pendant la mise à jour des playlists. Veuillez le réssayer à nouveau."),
        "notificationPlaylistUpdatedSuccessfully": m1,
        "notificationSuccessTitle":
            MessageLookupByLibrary.simpleMessage("<b>Succès!</b>"),
        "ok": MessageLookupByLibrary.simpleMessage("D\'accord"),
        "openInSpotify":
            MessageLookupByLibrary.simpleMessage("Ouvrir sur Spotify"),
        "playlistCreatedWithPlaylistmerger4Spotify":
            MessageLookupByLibrary.simpleMessage(
                "Playlist créée avec PlaylistMerger 4 Spotify"),
        "pleaseEnterThePlaylistName": MessageLookupByLibrary.simpleMessage(
            "Veuillez rentrer le nom de la playlist"),
        "pleaseLoginToSpotify": MessageLookupByLibrary.simpleMessage(
            "Veuillez vous connecter à Spotify"),
        "saving_threedots":
            MessageLookupByLibrary.simpleMessage("Mise à jour..."),
        "selectAPlaylist":
            MessageLookupByLibrary.simpleMessage("-- Choisir une playlist -- "),
        "settings": MessageLookupByLibrary.simpleMessage("Réglages..."),
        "sourcePlaylists":
            MessageLookupByLibrary.simpleMessage("Playlists d\'origine"),
        "spotifyUser":
            MessageLookupByLibrary.simpleMessage("Utilisateur de Spotify"),
        "updateThisInSpotify":
            MessageLookupByLibrary.simpleMessage("Mettre à jour sur Spotify"),
        "we_will_open_login": MessageLookupByLibrary.simpleMessage(
            "Pour débuter, la page de connexion de Spotify s\'ouvrira."),
        "welcome": MessageLookupByLibrary.simpleMessage("Bienvenue")
      };
}
