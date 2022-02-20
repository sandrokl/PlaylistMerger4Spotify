import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: const EdgeInsets.all(0),
                value: true,
                onChanged: (newValue) {},
                title: Text(S.of(context).settingsAutomaticUpdates),
                subtitle: Text(S.of(context).settingsAutomaticUpdatesDescription),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).settingsApplicationTheme,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  DropdownButton<String>(
                    value: 'system',
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    underline: Container(
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (String? newValue) {},
                    items: <Map<String, String>>[
                      {'value': 'system', 'text': S.of(context).settingsUseSystemTheme},
                      {'value': 'light', 'text': S.of(context).settingsUseLightTheme},
                      {'value': 'dark', 'text': S.of(context).settingsUseDarkTheme},
                    ].map<DropdownMenuItem<String>>((Map<String, String> value) {
                      return DropdownMenuItem<String>(
                        value: value['value'],
                        child: Text(value['text']!),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).settingsLanguage,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  DropdownButton<String>(
                    value: 'automatic',
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    underline: Container(
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (String? newValue) {},
                    items: <Map<String, String>>[
                      {'value': 'automatic', 'text': S.of(context).settingsLanguageAutomatic},
                      {'value': 'en', 'text': 'English'},
                      {'value': 'fr', 'text': 'Français'},
                      {'value': 'pt', 'text': 'Português'},
                    ].map<DropdownMenuItem<String>>((Map<String, String> value) {
                      return DropdownMenuItem<String>(
                        value: value['value'],
                        child: Text(value['text']!),
                      );
                    }).toList(),
                  ),
                ],
              ),
              ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.all(0),
                title: Text(S.of(context).settingsMergingHistory),
                trailing: const Icon(Icons.arrow_right),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(S.of(context).settingsSupport),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: S.of(context).settingsIfYouWantToContact,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                        text: S.of(context).settingsByEmail,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = "mailto:sandro.kl.80@gmail.com?subjet=PlaylistMerger 4 Spotify";
                            await launch(url);
                          }),
                    TextSpan(
                      text: ".",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
