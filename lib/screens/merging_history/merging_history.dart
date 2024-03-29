// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/merging_results.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:provider/provider.dart';

class MergingHistory extends StatefulWidget {
  const MergingHistory({Key? key}) : super(key: key);

  @override
  _MergingHistoryState createState() => _MergingHistoryState();
}

class _MergingHistoryState extends State<MergingHistory> {
  final _listMergedPlaylists = <Playlist>[];
  final _listMergingHistory = <MergingResult>[];

  var _selectedFilter = "";

  List<MergingResult> get _filteredList {
    if (_selectedFilter == "") {
      return _listMergingHistory;
    } else {
      return _listMergingHistory.where((e) => e.playlistId == _selectedFilter).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      final db = Provider.of<AppDatabase>(context, listen: false);
      final merged = await db.playlistsDao.getMergedPlaylists();
      var history = await db.mergingResultsDao.getAll(limit: 500, mostRecentFirst: true);
      history = history.where((h) => merged.where((m) => m.playlistId == h.playlistId).isNotEmpty).toList();

      setState(() {
        _listMergedPlaylists.addAll(merged);
        _listMergingHistory.addAll(history);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).historyRecentUpdates)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: "",
                    child: Text(S.of(context).historyViewAllPlaylistsHistory),
                  ),
                  ..._listMergedPlaylists
                      .map((e) => DropdownMenuItem<String>(
                            value: e.playlistId,
                            child: Text(e.name),
                          ))
                      .toList(),
                ],
                onChanged: (newValue) {
                  setState(() {
                    if (newValue != null) _selectedFilter = newValue;
                  });
                },
                isExpanded: true,
                value: _selectedFilter),
            Expanded(
              child: Scrollbar(
                trackVisibility: true,
                thickness: 1.0,
                child: ListView.separated(
                  padding: const EdgeInsets.only(right: 8.0),
                  itemBuilder: ((context, index) {
                    final item = _filteredList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _listMergedPlaylists.firstWhere((p) => p.playlistId == item.playlistId).name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(DateFormat.yMd().add_jms().format(item.runDate)),
                        Text(S.of(context).historyResult +
                            (item.successed ? S.of(context).historySuccess : S.of(context).historyFail)),
                        Text(
                          S.of(context).historyTracksAddedRemoved(
                              item.tracksAdded?.toString() ?? S.of(context).historyNA,
                              item.tracksRemoved?.toString() ?? S.of(context).historyNA),
                        ),
                        Text(
                          S.of(context).historyPromptedBy(item.triggeredBy == TriggeredBy.user
                              ? S.of(context).historyYou
                              : S.of(context).historyAutomaticUpdate),
                        ),
                      ],
                    );
                  }),
                  separatorBuilder: (_, __) {
                    return Divider(
                      color: Theme.of(context).primaryColor,
                    );
                  },
                  itemCount: _filteredList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
