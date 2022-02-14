import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';

class ItemDefinition {
  late IconData icon;
  late String value;
  late String text;
  ItemDefinition(this.icon, this.value, this.text);
}

List<PopupMenuItem<String>> getPopUpMenuItems(BuildContext context) {
  var items = [
    ItemDefinition(Icons.file_upload, "export", S.of(context).exportMergingDefinitions),
    ItemDefinition(Icons.file_download, "import", S.of(context).importMergingDefinitions),
    // ItemDefinition(Icons.settings, "settings", S.of(context).settings),
  ];
  return items
      .map((item) => PopupMenuItem<String>(
            value: item.value,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    item.icon,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                Text(
                  item.text,
                ),
              ],
            ),
          ))
      .toList();
}
