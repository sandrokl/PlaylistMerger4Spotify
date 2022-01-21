import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';
import 'package:playlistmerger4spotify/screens/my_home_page/user_info.dart';
import 'package:playlistmerger4spotify/store/spotify_user_store.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Playlist>>? listMergedPlaylists;

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
      listMergedPlaylists =
          context.read<AppDatabase>().playlistsDao.getMergedPlaylists();
    });
  }

  Future<void> _removeMergedPlaylist(int index) async {
    var list = await listMergedPlaylists;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
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
              future: listMergedPlaylists,
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
                                                          .pop(true),
                                                  child: Text(
                                                      S.of(context).delete)),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child:
                                                    Text(S.of(context).cancel),
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
                                    child: ListTile(
                                      title: Text(p.name),
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
