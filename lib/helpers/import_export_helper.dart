import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:playlistmerger4spotify/models/backup_info.dart';

Future<void> exportMergingDefinitions(BuildContext context) async {
  String? result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Choose folder to export file");
  if (result != null) {
    File file = File(join(result, "pm4s-export-${DateTime.now().millisecondsSinceEpoch}.pm4s"));
    final info = await PackageInfo.fromPlatform();
    var appId = info.packageName;
    var appVersion = info.version;

    // TODO read from database and save to file
  }
}

Future<void> importMergingDefinitions(BuildContext context) async {
  var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["json", "pm4s"],
      dialogTitle: "Choose file to import");
  if (result != null) {
    var file = File(result.files.first.path!);
    var jsonString = await file.readAsString();
    var jsonObj = jsonDecode(jsonString);

    var backup = BackupInfo.fromJson(jsonObj);

    // TODO : add to database
  }
}
