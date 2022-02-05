import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/models/backup_info.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportMergingDefinitions(BuildContext context) async {
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

  final fileName = "pm4s-export-${(DateTime.now().millisecondsSinceEpoch / 1000).floor()}.json";
  final directory = await getTemporaryDirectory();
  final destinationFile = join(directory.path, fileName);

  final file = File(destinationFile);
  const jsonEncoder = JsonEncoder.withIndent("  ");
  final stringContent = jsonEncoder.convert(backupInfo);
  await file.writeAsString(stringContent);

  await Share.shareFiles(
    [file.path],
    mimeTypes: ["application/json"],
    subject: "teste1",
    text: "teste2",
  );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(S.of(context).mergingDefinitionsSavedSuccessfully),
    ),
  );
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
