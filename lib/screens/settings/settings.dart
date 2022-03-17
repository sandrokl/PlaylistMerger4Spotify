import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';
import 'package:playlistmerger4spotify/helpers/work_manager_helper.dart';
import 'package:playlistmerger4spotify/screens/merging_history/merging_history.dart';
import 'package:playlistmerger4spotify/store/theme_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _isUpdateSchedule = false;
  String? _currentLanguage;
  String? _currentTheme;

  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      final _sharedPrefs = await SharedPreferences.getInstance();
      setState(() {
        _isUpdateSchedule = _sharedPrefs.getBool("isUpdateSchedule") ?? false;
        _currentLanguage = _sharedPrefs.getString("appLanguage") ?? Intl.defaultLocale!;
        _currentTheme = _sharedPrefs.getString("appTheme") ?? AppThemes.system.name;
      });
    });
  }

  void _changeIsUpdateScheduled(bool newIsUpdateScheduled) async {
    if (newIsUpdateScheduled) {
      await WorkManagerHelper().createUpdateSchedule(
        NotificationsHelper.CHANNEL_KEY_IN_PROGRESS,
        S.of(context).notificationInProgressChannelName,
        S.of(context).notificationInProgressMessage,
      );
    } else {
      await WorkManagerHelper().deleteUpdateSchedule();
    }

    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.setBool("isUpdateSchedule", newIsUpdateScheduled);
    setState(() {
      _isUpdateSchedule = newIsUpdateScheduled;
    });
  }

  void _changeLanguage(String? newLang) async {
    if (newLang != null) {
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setString("appLanguage", newLang);
      await S.load(Locale(newLang));
      setState(() {
        _currentLanguage = newLang;
      });
    }
  }

  void _changeTheme(String? newTheme) async {
    if (newTheme != null) {
      final theme = AppThemes.values.firstWhere((t) => t.name == newTheme);
      context.read<ThemeStore>().setTheme(theme);
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setString("appTheme", newTheme);
      setState(() {
        _currentTheme = theme.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          isAlwaysShown: true,
          thickness: 1.0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  value: _isUpdateSchedule,
                  onChanged: _changeIsUpdateScheduled,
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
                      value: _currentTheme,
                      underline: Container(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      onChanged: _changeTheme,
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
                      value: _currentLanguage ?? 'en',
                      underline: Container(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      onChanged: _changeLanguage,
                      items: <Map<String, String>>[
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MergingHistory()));
                  },
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(S.of(context).settingsMergingHistory),
                  trailing: const Icon(Icons.arrow_right),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(S.of(context).settingsSupport),
                  subtitle: Text(S.of(context).settingsIfYouWantToContact),
                  trailing: IconButton(
                    onPressed: () async {
                      var url = "mailto:sandro.kl.80@gmail.com?subject=PlaylistMerger 4 Spotify";
                      await launch(url);
                    },
                    icon: const Icon(Icons.email),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
