import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';

class MergingHistory extends StatefulWidget {
  const MergingHistory({Key? key}) : super(key: key);

  @override
  _MergingHistoryState createState() => _MergingHistoryState();
}

class _MergingHistoryState extends State<MergingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settingsMergingHistory)),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("merging history"),
      ),
    );
  }
}
