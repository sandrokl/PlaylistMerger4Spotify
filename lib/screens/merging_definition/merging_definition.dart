import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';
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
  List<PlaylistToIgnore> _playlistsToIgnore = [];

  bool _doNotShowAgainChecked = false;

  final _formKey = GlobalKey<FormState>();
  final _newPlaylistName = TextEditingController();

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
            key: _formKey,
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
                    controller: _newPlaylistName,
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
                          _newPlaylistName.text = "";
                          Navigator.of(context).pop();
                        },
                        child: Text(S.of(context).cancel),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _createNewPlaylist(_newPlaylistName.text);
                            _newPlaylistName.text = "";
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

  _showAddIgnorePlaylist() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              16.0,
              16.0,
              16.0,
              MediaQuery.of(context).viewInsets.bottom + 24.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: S.of(context).excludePasteLinkToThePlaylist,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.keyboard_double_arrow_right),
                      onPressed: () {},
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).howToAddToExcludeList,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.open_in_new_outlined),
                                  onPressed: () async {
                                    await launch('https://sandrokl.net/playlistmerger4spotify/addtoignore/');
                                  },
                                )
                              ],
                            )),
                        ..._playlistsToIgnore.map((e) {
                          return ListTile(
                            title: Text(e.name),
                            subtitle: Text(e.ownerName),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        }).toList(),
                        if (_playlistsToIgnore.isEmpty) Text(S.of(context).excludeNothingHere),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _createNewPlaylist(String playlistName) async {
    final userId = _userStore.user!.id;
    var spotifyClient = SpotifyClient();
    var createdPlaylist = await spotifyClient.createNewPlaylist(context, userId, playlistName);
    await Provider.of<AppDatabase>(context, listen: false).playlistsDao.insertAll([createdPlaylist]);
    _loadPlaylistsForScreen();
    _selectedDestinationPlaylist = createdPlaylist.playlistId;
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
          _playlistsToIgnore = pToIgnore;
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
      await _db.playlistsToIgnoreDao.updateIgnoredPlaylists(_selectedDestinationPlaylist!, _playlistsToIgnore);
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.merge),
                label: 'To Merge',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.merge),
                label: 'To Exclude',
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
          padding: const EdgeInsets.all(16.0),
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
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          S.of(context).playlistIgnoreList,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _selectedTab == 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).howToAddToExcludeList,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              IconButton(
                                icon: const Icon(Icons.open_in_new_outlined),
                                onPressed: () async {
                                  await launch('https://sandrokl.net/playlistmerger4spotify/addtoignore/');
                                },
                              )
                            ],
                          )),
                      ..._playlistsToIgnore.map((e) {
                        return ListTile(
                          title: Text(e.name),
                          subtitle: Text(e.ownerName),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      }).toList(),
                      if (_playlistsToIgnore.isEmpty) Text(S.of(context).excludeNothingHere),
                    ],
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
