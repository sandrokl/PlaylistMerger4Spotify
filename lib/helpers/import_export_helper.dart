import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/models/backup_info.dart';
import 'package:provider/provider.dart';

Future<void> exportMergingDefinitions(BuildContext context) async {
  String? result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Choose folder to export file");
  if (result != null) {
    final info = await PackageInfo.fromPlatform();

    var backupInfo =
        BackupInfo(appId: info.packageName, version: info.version, date: DateTime.now().toUtc().toIso8601String());
    backupInfo.rules = [];

    final db = Provider.of<AppDatabase>(context, listen: false);
    var mergings = await db.playlistsDao.getMergedPlaylists();

    for (var destination in mergings) {
      var r = Rule(destinationId: destination.playlistId, destinationName: destination.name);
      r.sources = [];

      var sourcesId = await db.playlistsToMergeDao.getPlaylistsToMergeByDestinationId(destination.playlistId);
      var sources = await db.playlistsDao.getPlaylistsByIdList(sourcesId.map((e) => e.sourcePlaylistId).toList());
      for (var source in sources) {
        r.sources!.add(Source(id: source.playlistId, name: source.name, owner: source.ownerId));
      }

      backupInfo.rules!.add(r);
    }

    File file = File(join(result, "pm4s-export-${(DateTime.now().millisecondsSinceEpoch / 1000).floor()}.json"));
    var jsonEncoder = const JsonEncoder.withIndent('  ');
    file.writeAsString(jsonEncoder.convert(backupInfo.toJson()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).mergingDefinitionsSavedSuccessfully),
      ),
    );
  }
}

Future<void> importMergingDefinitions(BuildContext context) async {
  var result = await FilePicker.platform.pickFiles(
      allowMultiple: false, type: FileType.custom, allowedExtensions: ["json"], dialogTitle: "Choose file to import");
  if (result != null) {
    var file = File(result.files.first.path!);
    var jsonString = await file.readAsString();
    var jsonObj = jsonDecode(jsonString);

    var backup = BackupInfo.fromJson(jsonObj);

    // TODO : add to database
  }
}
