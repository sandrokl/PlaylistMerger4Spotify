import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playlistmerger4spotify/store/spotify_user_store.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SpotifyUserStore>(context);

    return Observer(builder: (context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: (store.user?.photoUrl == null
                    ? const Icon(
                        Icons.account_box_outlined,
                        size: 50.0,
                      )
                    : Image(
                        image: CachedNetworkImageProvider(store.user!.photoUrl!),
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.fitHeight,
                      )),
              ),
              Expanded(
                child: Text(
                  (store.user?.name == null)
                      ? (store.user == null ? "" : S.of(context).spotifyUser)
                      : store.user?.name as String,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
