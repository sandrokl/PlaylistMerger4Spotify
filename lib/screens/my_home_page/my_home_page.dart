import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';
import 'package:playlistmerger4spotify/screens/merging_definition/merging_definition.dart';
import 'package:playlistmerger4spotify/screens/my_home_page/user_info.dart';
import 'package:playlistmerger4spotify/store/spotify_user_store.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Playlist>>? _listMergedPlaylists;
  bool _fabVisible = false;

  @override
  void initState() {
    super.initState();

    final spotifyClient = SpotifyClient();
    spotifyClient.getUserFromSession().then((user) async {
      context.read<SpotifyUserStore>().setUser(user);

      final listPlaylistsFromSpotify = await spotifyClient.getUserPlaylists();

      final dao = context.read<AppDatabase>().playlistsDao;
      await dao.invalidateAllPlaylists();
      await dao.insertAll(listPlaylistsFromSpotify);
      await dao.deleteAllInvalidatedPlaylists();

      _updateListMergedPlaylists();
    });
  }

  _updateListMergedPlaylists() {
    setState(() {
      _listMergedPlaylists =
          context.read<AppDatabase>().playlistsDao.getMergedPlaylists();
      _fabVisible = true;
    });
  }

  Future<void> _removeMergedPlaylist(int index) async {
    var list = await _listMergedPlaylists;
    var id = list![index].playlistId;

    await context
        .read<AppDatabase>()
        .playlistsToMergeDao
        .deleteMergedPlaylist(id);
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      floatingActionButton: Visibility(
        visible: _fabVisible,
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const MergingDefinition();
                },
              ),
            );
            _updateListMergedPlaylists();
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: UserInfo(),
            ),
            FutureBuilder<List<Playlist>>(
              future: _listMergedPlaylists,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return snapshot.data!.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Text(
                                    S.of(context).nothingHereForNow,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var p = snapshot.data![index];
                                  return Dismissible(
                                    key: Key(p.name +
                                        DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString()),
                                    direction: DismissDirection.horizontal,
                                    confirmDismiss:
                                        (DismissDirection direction) async {
                                      return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(S.of(context).confirm),
                                            content: RichText(
                                              text: TextSpan(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                text: S
                                                    .of(context)
                                                    .areYouSureYouWishToDelete_start,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: p.name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TextSpan(
                                                      text: S
                                                          .of(context)
                                                          .areYouSureYouWishToDelete_end),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child:
                                                    Text(S.of(context).cancel),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child:
                                                    Text(S.of(context).delete),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    secondaryBackground: Container(
                                      color: Colors.red,
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    background: Container(
                                      color: Colors.red,
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      _removeMergedPlaylist(index);
                                    },
                                    child: GestureDetector(
                                      onTap: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(p.name),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 16.0),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      dense: true,
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                        launch(p.playUrl);
                                                      },
                                                      title: Text(
                                                        S
                                                            .of(context)
                                                            .openInSpotify,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      leading: const Icon(Icons
                                                          .play_circle_fill_outlined),
                                                    ),
                                                    ListTile(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      dense: true,
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                MergingDefinition(
                                                              editingPlaylistId:
                                                                  p.playlistId,
                                                            ),
                                                          ),
                                                        );
                                                        _updateListMergedPlaylists();
                                                      },
                                                      title: Text(
                                                        S
                                                            .of(context)
                                                            .modifyThisMergingRule,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      leading: const Icon(
                                                          Icons.edit_rounded),
                                                    ),
                                                    ListTile(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      dense: true,
                                                      onTap: () async {
                                                        await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(S
                                                                  .of(context)
                                                                  .confirm),
                                                              content: RichText(
                                                                text: TextSpan(
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2,
                                                                  text: S
                                                                      .of(context)
                                                                      .areYouSureYouWishToDelete_start,
                                                                  children: <
                                                                      TextSpan>[
                                                                    TextSpan(
                                                                      text: p
                                                                          .name,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    TextSpan(
                                                                        text: S
                                                                            .of(context)
                                                                            .areYouSureYouWishToDelete_end),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(),
                                                                  child: Text(S
                                                                      .of(context)
                                                                      .cancel),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await _removeMergedPlaylist(
                                                                        index);
                                                                    Navigator.popUntil(
                                                                        context,
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            route.isFirst);
                                                                  },
                                                                  child: Text(S
                                                                      .of(context)
                                                                      .delete),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      title: Text(
                                                        S
                                                            .of(context)
                                                            .deleteThisMergingRule,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      leading: const Icon(
                                                          Icons.delete),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: ListTile(
                                        title: Text(p.name),
                                        trailing: const Icon(
                                          Icons.more_vert,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: Center(
                          child: Text(snapshot.error.toString()),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              S.of(context).nothingHereForNow,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
