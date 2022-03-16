import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';
import 'package:playlistmerger4spotify/models/playlist_info_for_exclusion.dart';
import 'package:playlistmerger4spotify/store/spotify_user_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MergingDefinition extends StatefulWidget {
  final String? editingPlaylistId;

  const MergingDefinition({this.editingPlaylistId, Key? key}) : super(key: key);

  @override
  _MergingDefinitionState createState() => _MergingDefinitionState();
}

class _MergingDefinitionState extends State<MergingDefinition> {
  Future<List<Playlist>>? _destinationPlaylistOptions;
  Future<List<Playlist>>? _sourcePlaylistsOptions;

  String? _selectedDestinationPlaylist;
  int _selectedTab = 0;
  List<String> _selectedSourcePlaylists = [];
  List<PlaylistToIgnore> _playlistsToExclude = [];

  bool _doNotShowAgainChecked = false;

  final _formKeyCreate = GlobalKey<FormState>();
  final _formKeyAddExclude = GlobalKey<FormState>();
  final _newPlaylistNameController = TextEditingController();
  final _playlinkLinkController = TextEditingController();
  final _playlistLinkRegex = RegExp(r'(?<=\/playlist\/).*?(?=\?|$)', caseSensitive: false);

  PlaylistInfoForExclusion? _tempPlaylistForExclusion;

  late final SpotifyUserStore _userStore;

  final _doNotShowAgainKey = "doNotShowAgain";

  void _showCreateNewPlaylist() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Form(
            key: _formKeyCreate,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).createNewPlaylist,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextFormField(
                    controller: _newPlaylistNameController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: S.of(context).nameOfThePlaylist,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterThePlaylistName;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _newPlaylistNameController.text = "";
                          Navigator.of(context).pop();
                        },
                        child: Text(S.of(context).cancel),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_formKeyCreate.currentState!.validate()) {
                            await _createNewPlaylist(_newPlaylistNameController.text);
                            _newPlaylistNameController.text = "";
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(S.of(context).createIt),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddExcludePlaylist() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  16.0,
                  16.0,
                  16.0,
                  MediaQuery.of(context).viewInsets.bottom + 24.0,
                ),
                child: Form(
                  key: _formKeyAddExclude,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          S.of(context).excludeTitle,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _playlinkLinkController,
                              keyboardType: TextInputType.url,
                              decoration: InputDecoration(
                                labelText: S.of(context).excludePasteLinkToThePlaylist,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty || !_playlistLinkRegex.hasMatch(value)) {
                                  return S.of(context).validationPlaylistLink;
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.keyboard_double_arrow_right),
                            onPressed: () async {
                              if (_formKeyAddExclude.currentState!.validate()) {
                                final id = _playlistLinkRegex.stringMatch(_playlinkLinkController.text)!;
                                var playlist = await SpotifyClient().getPlaylistInfo(id);
                                setState(() {
                                  _tempPlaylistForExclusion = playlist;
                                });
                                FocusScope.of(context).unfocus();
                              }
                            },
                          ),
                        ],
                      ),
                      if (_tempPlaylistForExclusion != null)
                        Visibility(
                          visible: _tempPlaylistForExclusion != null,
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            leading: SizedBox.fromSize(
                              size: const Size(50.0, 50.0),
                              child: Image.network(_tempPlaylistForExclusion!.playlistCoverArt),
                            ),
                            title: Text(
                              _tempPlaylistForExclusion!.name,
                            ),
                            subtitle: Text(
                              S.of(context).subTitlePlaylistToExclude(
                                    _tempPlaylistForExclusion!.ownerName,
                                    _tempPlaylistForExclusion!.totalTracks,
                                  ),
                            ),
                          ),
                        ),
                      if (_tempPlaylistForExclusion != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.of(context).cancel),
                            ),
                            TextButton(
                              onPressed: _addToExcludeList,
                              child: Text(S.of(context).confirm.toUpperCase()),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        });
    _playlinkLinkController.clear();
    _tempPlaylistForExclusion = null;
  }

  Future<void> _createNewPlaylist(String playlistName) async {
    final userId = _userStore.user!.id;
    var spotifyClient = SpotifyClient();
    var createdPlaylist = await spotifyClient.createNewPlaylist(context, userId, playlistName);
    await Provider.of<AppDatabase>(context, listen: false).playlistsDao.insertAll([createdPlaylist]);
    _loadPlaylistsForScreen();
    _selectedDestinationPlaylist = createdPlaylist.playlistId;
  }

  void _addToExcludeList() {
    if (_playlistsToExclude.where((p) => p.playlistId == _tempPlaylistForExclusion!.playlistId).isEmpty) {
      setState(() {
        _playlistsToExclude.add(PlaylistToIgnore(
          destinationPlaylistId: '',
          playlistId: _tempPlaylistForExclusion!.playlistId,
          name: _tempPlaylistForExclusion!.name,
          ownerId: _tempPlaylistForExclusion!.ownerId,
          ownerName: _tempPlaylistForExclusion!.ownerName,
          openUrl: _tempPlaylistForExclusion!.openUrl,
        ));
        _playlistsToExclude.sort((a, b) => a.name.compareTo(b.name));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).exclusionPlaylistAlreadyAdded),
        ),
      );
    }
    Navigator.of(context).pop();
  }

  void _loadPlaylistsForScreen() {
    final _db = context.read<AppDatabase>();
    final _userId = _userStore.user!.id;

    if (widget.editingPlaylistId == null) {
      _destinationPlaylistOptions = _db.playlistsDao.getPossibleNewMergingPlaylists(_userId);
    } else {
      _selectedDestinationPlaylist = widget.editingPlaylistId!;
      _destinationPlaylistOptions = _db.playlistsDao.getPlaylistsByIdList([widget.editingPlaylistId!]);
      _db.playlistsToMergeDao.getPlaylistsToMergeByDestinationId(widget.editingPlaylistId!).then((list) async {
        final pToIgnore = (await _db.playlistsToIgnoreDao.getByDestinationId(_selectedDestinationPlaylist!));

        setState(() {
          _selectedSourcePlaylists = list.map((p) => p.sourcePlaylistId).toList();
          _playlistsToExclude = pToIgnore..sort((a, b) => a.name.compareTo(b.name));
        });
      });
    }

    setState(() {
      _sourcePlaylistsOptions = _db.playlistsDao.getAllUserPlaylists();
    });
  }

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<SpotifyUserStore>(context, listen: false);

    _loadPlaylistsForScreen();

    Timer.run(() async {
      final sp = await SharedPreferences.getInstance();
      final doNotShowAgain = sp.getBool(_doNotShowAgainKey) ?? false;

      if (widget.editingPlaylistId == null && !doNotShowAgain) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text(S.of(context).carefulexclamation),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(S.of(context).makeSureToChooseAPlaylistYouDontDirectlyAdd),
                          CheckboxListTile(
                            visualDensity: VisualDensity.compact,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              S.of(context).doNotShowAgain,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            value: _doNotShowAgainChecked,
                            onChanged: (newValue) {
                              setState(() {
                                _doNotShowAgainChecked = newValue!;
                              });
                            },
                          )
                        ],
                      ),
                      actionsPadding: EdgeInsets.zero,
                      actions: [
                        TextButton(
                          onPressed: () async {
                            if (_doNotShowAgainChecked) {
                              final sp = await SharedPreferences.getInstance();
                              await sp.setBool(_doNotShowAgainKey, true);
                            }

                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).dismiss),
                        ),
                      ],
                    );
                  },
                ));
      }
    });
  }

  Future<void> saveChanges() async {
    var _db = Provider.of<AppDatabase>(context, listen: false);
    if (_selectedDestinationPlaylist != null) {
      await _db.playlistsToMergeDao.updateMergedPlaylist(_selectedDestinationPlaylist!, _selectedSourcePlaylists);
      await _db.playlistsToIgnoreDao.updateIgnoredPlaylists(_selectedDestinationPlaylist!, _playlistsToExclude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).saving_threedots),
          ),
        );
        await saveChanges();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (_selectedDestinationPlaylist != null &&
            _selectedDestinationPlaylist!.isNotEmpty &&
            _selectedSourcePlaylists.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).changesSaved),
            ),
          );
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appTitle),
        ),
        bottomNavigationBar: SizedBox(
          height: 50.0,
          child: BottomNavigationBar(
            elevation: 16.0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.call_merge),
                label: S.of(context).definitionToMerge,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.call_merge),
                label: S.of(context).definitionToExclude,
              ),
            ],
            currentIndex: _selectedTab,
            selectedFontSize: 16,
            unselectedFontSize: 14,
            iconSize: 0.0,
            onTap: (index) {
              setState(() => _selectedTab = index);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).destinationPlaylist,
                style: Theme.of(context).textTheme.headline6,
              ),
              FutureBuilder<List<Playlist>>(
                future: _destinationPlaylistOptions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              items: snapshot.data!.map((e) {
                                return DropdownMenuItem<String>(
                                  child: Text(e.name),
                                  value: e.playlistId,
                                );
                              }).toList(),
                              isExpanded: true,
                              hint: widget.editingPlaylistId != null
                                  ? null
                                  : Text(
                                      S.of(context).selectAPlaylist,
                                      style: const TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.start,
                                    ),
                              value: _selectedDestinationPlaylist,
                              onChanged: widget.editingPlaylistId == null
                                  ? (newValue) {
                                      setState(() {
                                        _selectedDestinationPlaylist = newValue;
                                        _selectedSourcePlaylists.remove(newValue);
                                      });
                                    }
                                  : null,
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                            onPressed: widget.editingPlaylistId != null ? null : _showCreateNewPlaylist,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Visibility(
                visible: _selectedTab == 0,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          S.of(context).sourcePlaylists,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _selectedTab == 0,
                child: Expanded(
                  child: FutureBuilder<List<Playlist>>(
                    future: _sourcePlaylistsOptions,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: snapshot.data!.map((e) {
                                return CheckboxListTile(
                                  contentPadding: const EdgeInsets.only(right: 0.0, left: 0.0),
                                  visualDensity: VisualDensity.compact,
                                  value: (e.playlistId != _selectedDestinationPlaylist &&
                                      _selectedSourcePlaylists.contains(e.playlistId)),
                                  title: Text(e.name),
                                  onChanged: _selectedDestinationPlaylist != e.playlistId
                                      ? (newValue) {
                                          if (e.playlistId != _selectedDestinationPlaylist) {
                                            setState(() {
                                              if (newValue != null) {
                                                if (newValue) {
                                                  _selectedSourcePlaylists.add(e.playlistId);
                                                } else {
                                                  _selectedSourcePlaylists.remove(e.playlistId);
                                                }
                                              }
                                            });
                                          }
                                        }
                                      : null,
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              Visibility(
                visible: _selectedTab == 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).playlistIgnoreList,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                      onPressed: _showAddExcludePlaylist,
                      icon: const Icon(Icons.playlist_add),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _selectedTab == 1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  S.of(context).howToAddToExcludeList,
                                  style: Theme.of(context).textTheme.labelMedium,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.open_in_new_outlined),
                                onPressed: () async {
                                  await launch('https://sandrokl.net/playlistmerger4spotify/add-to-exclude-list/');
                                },
                              )
                            ],
                          ),
                        ),
                        ..._playlistsToExclude.map((e) {
                          return ListTile(
                            contentPadding: const EdgeInsets.all(0.0),
                            title: Text(e.name),
                            subtitle: Text(e.ownerName),
                            visualDensity: VisualDensity.compact,
                            trailing: IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(S.of(context).confirm),
                                      content: RichText(
                                        text: TextSpan(
                                          style: Theme.of(context).textTheme.bodyText2,
                                          text: S.of(context).excludeList_AreYouSureDelete,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: e.name,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            const TextSpan(text: ' ?'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: Text(S.of(context).cancel),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              _playlistsToExclude.remove(e);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text(S.of(context).delete),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        }).toList(),
                        if (_playlistsToExclude.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Text(S.of(context).excludeNothingHere),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
