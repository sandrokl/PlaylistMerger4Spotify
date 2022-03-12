import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class MergingIgnore extends StatefulWidget {
  final List<PlaylistToIgnore> playlistsToIgnore;

  const MergingIgnore(this.playlistsToIgnore, {Key? key}) : super(key: key);

  @override
  State<MergingIgnore> createState() => _MergingIgnoreState();
}

class _MergingIgnoreState extends State<MergingIgnore> {
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
                          labelText: S.of(context).ignorePasteLinkToThePlaylist,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.keyboard_double_arrow_right),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).playlistIgnoreList),
        actions: [
          IconButton(
            onPressed: _showAddIgnorePlaylist,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(widget.playlistsToIgnore);
          return false;
        },
        child: Padding(
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
                          S.of(context).howToAddToIgnoreList,
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
                ...widget.playlistsToIgnore.map((e) {
                  return ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.ownerName),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                  );
                }).toList(),
                if (widget.playlistsToIgnore.isEmpty) Text(S.of(context).ignoreNothingHere),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
