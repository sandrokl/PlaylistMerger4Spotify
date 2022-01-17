import 'package:flutter/material.dart';
import 'package:playlistmerger_4_spotify/database/database.dart';
import 'package:playlistmerger_4_spotify/generated/l10n.dart';
import 'package:playlistmerger_4_spotify/models/spotify_user.dart';
import 'package:playlistmerger_4_spotify/screens/my_home_page/user_info.dart';
import 'package:playlistmerger_4_spotify/store/spotify_user_store.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    SpotifyUser.getFromSession().then((user) {
      context.read<SpotifyUserStore>().setUser(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: remove later. here to force the database creation only
    context.read<AppDatabase>().playlistsDao.getAllUserPlaylists().then((resp) {
      // do nothing
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: UserInfo(),
            ),
          ],
        ),
      ),
    );
  }
}
