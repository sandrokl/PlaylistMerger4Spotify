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
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var p = snapshot.data![index];
                            return Dismissible(
                              key: Key(p.name +
                                  DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              child: ListTile(
                                title: Text(p.name),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return Container();
                      // TODO implement no data and no error (empty list)
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
