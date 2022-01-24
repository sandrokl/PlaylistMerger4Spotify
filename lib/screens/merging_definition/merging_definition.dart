import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';

class MergingDefinition extends StatefulWidget {
  final String? editingPlaylistId;

  const MergingDefinition({this.editingPlaylistId, Key? key}) : super(key: key);

  @override
  _MergingDefinitionState createState() => _MergingDefinitionState();
}

class _MergingDefinitionState extends State<MergingDefinition> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).saving_threedots),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appTitle),
        ),
        body: Container(),
      ),
    );
  }
}
