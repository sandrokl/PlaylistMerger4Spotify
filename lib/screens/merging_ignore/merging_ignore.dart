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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).playlistIgnoreList),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(widget.playlistsToIgnore);
          return false;
        },
        child: Center(
          child: Text("hello world : ${widget.playlistsToIgnore.length}"),
        ),
      ),
    );
  }
}
