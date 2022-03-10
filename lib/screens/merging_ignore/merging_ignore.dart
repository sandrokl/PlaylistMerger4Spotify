import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';

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
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextField(),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).cancel),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).createIt),
                      ),
                    ],
                  ),
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
                          onPressed: () {},
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
