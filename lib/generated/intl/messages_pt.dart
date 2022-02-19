// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: 'Uma atualização de playlist está em progresso. Avisaremos quando tudo estiver pronto.', other: 'As atualizações de suas playlists estão em progresso. Avisaremos quando tudo estiver pronto.')}";

  static String m1(name) =>
      "&#128516 Sua playlist combinada <em>${name}</em> foi atualizada com sucesso.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "anUpdateToYourPlaylistIsBeingMadeInSpotify": m0,
        "appTitle":
            MessageLookupByLibrary.simpleMessage("PlaylistMerger 4 Spotify"),
        "areYouSureYouWishToDelete_end": MessageLookupByLibrary.simpleMessage(
            "? Isto não irá excluir a playlist no Spotify."),
        "areYouSureYouWishToDelete_start": MessageLookupByLibrary.simpleMessage(
            "Tem certeza que deseja excluir a definição para "),
        "cancel": MessageLookupByLibrary.simpleMessage("cancelar"),
        "carefulexclamation": MessageLookupByLibrary.simpleMessage("Atenção!"),
        "changesSaved": MessageLookupByLibrary.simpleMessage(
            "Alterações salvas. Você pode executar uma nova atualização no Spotify."),
        "channelNameMergingResults": MessageLookupByLibrary.simpleMessage(
            "Resultados dos updates de playlists"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "createIt": MessageLookupByLibrary.simpleMessage("CRIAR"),
        "createNewPlaylist":
            MessageLookupByLibrary.simpleMessage("Criar nova playlist"),
        "delete": MessageLookupByLibrary.simpleMessage("EXCLUIR"),
        "deleteThisMergingRule":
            MessageLookupByLibrary.simpleMessage("Excluir esta definição"),
        "destinationPlaylist":
            MessageLookupByLibrary.simpleMessage("Playlist de destino"),
        "dismiss": MessageLookupByLibrary.simpleMessage("FECHAR"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Não exibir novamente"),
        "exportMergingDefinitions":
            MessageLookupByLibrary.simpleMessage("Exportar definições"),
        "importMergingDefinitions":
            MessageLookupByLibrary.simpleMessage("Importar definições"),
        "makeSureToChooseAPlaylistYouDontDirectlyAdd":
            MessageLookupByLibrary.simpleMessage(
                "Quando você for escolher sua PLAYLIST DE DESTINO, tenha certeza de não escolher uma playlist que contenha sua música.\nEla vai ser apagada e substituída com o resultado da atualização."),
        "mergingDefinitionsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "As definições de combinação foram importadas com sucesso. As playlists ausentes de sua biblioteca atual não foram importadas."),
        "modifyThisMergingRule":
            MessageLookupByLibrary.simpleMessage("Modificar a definição"),
        "nameOfThePlaylist":
            MessageLookupByLibrary.simpleMessage("Nome da nova playlist"),
        "nothingHereForNow": MessageLookupByLibrary.simpleMessage(
            "Nada aqui por enquanto. Comece a criar suas playlists combinadas usando o botão abaixo."),
        "notificationAllPlaylistsUpdatedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "&#128516 Todas as playlists combinadas foram atualizadas com sucesso."),
        "notificationFailureTitle":
            MessageLookupByLibrary.simpleMessage("<b>Erro</b>"),
        "notificationInProgressChannelName":
            MessageLookupByLibrary.simpleMessage("Atualização em progresso"),
        "notificationInProgressMessage":
            MessageLookupByLibrary.simpleMessage("Atualizando playlist..."),
        "notificationMergingFailed": MessageLookupByLibrary.simpleMessage(
            "&#128577 Erro ao tentar atualizar suas playlists. Por favor tente novamente mais tarde."),
        "notificationPlaylistUpdatedSuccessfully": m1,
        "notificationSuccessTitle":
            MessageLookupByLibrary.simpleMessage("<b>Sucesso!</b>"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "openInSpotify":
            MessageLookupByLibrary.simpleMessage("Abrir no Spotify"),
        "playlistCreatedWithPlaylistmerger4Spotify":
            MessageLookupByLibrary.simpleMessage(
                "Playlist criada usando PlaylistMerger 4 Spotify"),
        "pleaseEnterThePlaylistName": MessageLookupByLibrary.simpleMessage(
            "Digite o nome da nova playlist"),
        "pleaseLoginToSpotify":
            MessageLookupByLibrary.simpleMessage("Faça login no Spotify"),
        "saving_threedots": MessageLookupByLibrary.simpleMessage("Salvando..."),
        "selectAPlaylist":
            MessageLookupByLibrary.simpleMessage("-- Escolha uma playlist -- "),
        "settings": MessageLookupByLibrary.simpleMessage("Opções..."),
        "sourcePlaylists":
            MessageLookupByLibrary.simpleMessage("Playlists de origem"),
        "spotifyUser": MessageLookupByLibrary.simpleMessage("Usuário Spotify"),
        "updateThisInSpotify":
            MessageLookupByLibrary.simpleMessage("Atualizar no Spotify"),
        "we_will_open_login": MessageLookupByLibrary.simpleMessage(
            "Para começar, a seguir vamos abrir a página de login do Spotify."),
        "welcome": MessageLookupByLibrary.simpleMessage("Bem vindo")
      };
}
