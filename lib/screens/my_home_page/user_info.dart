import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/store/spotify_user_store.dart';
import 'package:provider/provider.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<SpotifyUserStore>(
        builder: (context, userStore, child) => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: (userStore.user?.photoUrl == null
                      ? const Icon(
                          Icons.account_box_outlined,
                          size: 50.0,
                        )
                      : Image.network(
                          userStore.user?.photoUrl as String,
                          height: 50.0,
                          width: 50.0,
                          fit: BoxFit.fitHeight,
                        ))),
              Expanded(
                child: Text(
                  (userStore.user?.name == null)
                      ? S.of(context).spotifyUser
                      : userStore.user?.name as String,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
