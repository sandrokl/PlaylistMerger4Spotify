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
      final _db = Provider.of<AppDatabase>(context, listen: false);
      final merged = await _db.playlistsDao.getMergedPlaylists();
      var history = await _db.mergingResultsDao.getAll(limit: 500, mostRecentFirst: true);
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
                    child: Text(S.of(context).historyViewAllPlaylistsHistory),
                    value: "",
                  ),
                  ..._listMergedPlaylists
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e.name),
                            value: e.playlistId,
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
              child: ListView.separated(
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
                      Text(S.of(context).historyTracksAdded +
                          (item.tracksAdded?.toString() ?? S.of(context).historyNA) +
                          S.of(context).historySlashRemoved +
                          (item.tracksRemoved?.toString() ?? S.of(context).historyNA)),
                      Text(S.of(context).historyPromptedBy +
                          (item.triggeredBy == TriggeredBy.user
                              ? S.of(context).historyYou
                              : S.of(context).historyAutomaticUpdate)),
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
          ],
        ),
      ),
    );
  }
}
