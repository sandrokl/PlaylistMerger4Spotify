import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/store/spotify_user_store.dart';
import 'package:provider/provider.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';

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
  List<String> _selectedSourcePlaylists = [];

  @override
  void initState() {
    super.initState();

    final _db = context.read<AppDatabase>();
    final _userId = context.read<SpotifyUserStore>().user!.id;

    if (widget.editingPlaylistId == null) {
      _destinationPlaylistOptions =
          _db.playlistsDao.getPossibleNewMergingPlaylists(_userId);
    } else {
      _selectedDestinationPlaylist = widget.editingPlaylistId!;
      _destinationPlaylistOptions =
          _db.playlistsDao.getPlaylistsByIdList([widget.editingPlaylistId!]);
      _db.playlistsToMergeDao
          .getPlaylistsToMergeByDestinationId(widget.editingPlaylistId!)
          .then((list) {
        setState(() {
          _selectedSourcePlaylists =
              list.map((p) => p.sourcePlaylistId).toList();
        });
      });
    }

    setState(() {
      _sourcePlaylistsOptions = _db.playlistsDao.getAllUserPlaylists();
    });
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
        await Future.delayed(const Duration(seconds: 2));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appTitle),
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
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
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
                                });
                              }
                            : null,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  S.of(context).sourcePlaylists,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Playlist>>(
                  future: _sourcePlaylistsOptions,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: snapshot.data!.map((e) {
                              return CheckboxListTile(
                                contentPadding: const EdgeInsets.only(
                                    right: 0.0, left: 0.0),
                                visualDensity: VisualDensity.compact,
                                value: false,
                                title: Text(e.name),
                                onChanged:
                                    _selectedDestinationPlaylist != e.playlistId
                                        ? (newValue) {}
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
            ],
          ),
        ),
      ),
    );
  }
}
