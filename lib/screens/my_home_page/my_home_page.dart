// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/helpers/import_export_helper.dart';
import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';
import 'package:playlistmerger4spotify/helpers/work_manager_helper.dart';
import 'package:playlistmerger4spotify/screens/merging_definition/merging_definition.dart';
import 'package:playlistmerger4spotify/screens/my_home_page/appbar_popup_menu_items.dart';
import 'package:playlistmerger4spotify/screens/my_home_page/user_info.dart';
import 'package:playlistmerger4spotify/screens/settings/settings.dart';
import 'package:playlistmerger4spotify/store/spotify_user_store.dart';
import 'package:playlistmerger4spotify/store/theme_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:workmanager/workmanager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Playlist>>? _listMergedPlaylists;
  bool _fabVisible = false;

  final _spotifyClient = SpotifyClient();

  @override
  void initState() {
    super.initState();

    _spotifyClient.getUserFromSession().then((user) async {
      context.read<SpotifyUserStore>().setUser(user);

      await refreshUserPlaylistsFromSpotify(context);
    });

    SharedPreferences.getInstance().then((sharedPrefs) async {
      bool? isUpdateSchedule = sharedPrefs.getBool("isUpdateSchedule");
      if (isUpdateSchedule == null) {
        await WorkManagerHelper().createUpdateSchedule(
          NotificationsHelper.CHANNEL_KEY_IN_PROGRESS,
          S.of(context).notificationInProgressChannelName,
          S.of(context).notificationInProgressMessage,
        );
        await sharedPrefs.setBool("isUpdateSchedule", true);
      }

      var lang = sharedPrefs.getString("appLanguage");
      if (lang != null && lang != Intl.defaultLocale) {
        S.load(Locale(lang));
      }

      var currentTheme = sharedPrefs.getString("appTheme") ?? AppThemes.system.name;
      final theme = AppThemes.values.firstWhere((t) => t.name == currentTheme);
      Provider.of<ThemeStore>(context, listen: false).setTheme(theme);

      await NotificationsHelper().initialize();
    });
  }

  Future<void> refreshUserPlaylistsFromSpotify(BuildContext context) async {
    final listPlaylistsFromSpotify = await _spotifyClient.getUserPlaylists();

    final dao = context.read<AppDatabase>().playlistsDao;
    await dao.invalidateAllPlaylists();
    await dao.insertAll(listPlaylistsFromSpotify);
    await dao.deleteAllInvalidatedPlaylists();

    _updateListMergedPlaylists();
  }

  void _updateListMergedPlaylists() {
    setState(() {
      _listMergedPlaylists = context.read<AppDatabase>().playlistsDao.getMergedPlaylists();
      _fabVisible = true;
    });
  }

  Future<void> _removeMergedPlaylist(int index) async {
    var list = await _listMergedPlaylists;
    var id = list![index].playlistId;

    await context.read<AppDatabase>().playlistsToMergeDao.deleteMergedPlaylist(id);
    setState(() {
      list.removeAt(index);
    });
  }

  void _handleMenuItemSelect(String value) async {
    if (value == "export") {
      await exportMergingDefinitions(context);
    } else if (value == "import") {
      await importMergingDefinitions(context);
      _updateListMergedPlaylists();
    } else if (value == "settings") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const Settings(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        actions: [
          IconButton(
            onPressed: () async {
              await Workmanager().registerOneOffTask(
                DateTime.now().millisecond.toString(),
                WorkManagerHelper.TASK_DO_MERGING_NOW_ALL,
                inputData: {
                  "notificationChannelId": NotificationsHelper.CHANNEL_KEY_MERGING_RESULTS,
                  "notificationChannelName": S.of(context).channelNameMergingResults,
                  "successTitle": S.of(context).notificationSuccessTitle,
                  "successMessage": S.of(context).notificationAllPlaylistsUpdatedSuccessfully,
                  "failureTitle": S.of(context).notificationFailureTitle,
                  "failureMessage": S.of(context).notificationMergingFailed,
                  "notificationInProgressChannelId": NotificationsHelper.CHANNEL_KEY_IN_PROGRESS,
                  "notificationInProgressChannelName": S.of(context).notificationInProgressChannelName,
                  "notificationInProgressMessage": S.of(context).notificationInProgressMessage,
                },
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).anUpdateToYourPlaylistIsBeingMadeInSpotify(2)),
                ),
              );
            },
            icon: const Icon(Icons.call_merge),
            iconSize: 30.0,
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuItemSelect,
            itemBuilder: (BuildContext context) {
              return getPopUpMenuItems(context);
            },
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: _fabVisible,
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const MergingDefinition();
                },
              ),
            );
            _updateListMergedPlaylists();
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: UpgradeAlert(
        upgrader: Upgrader(
          showReleaseNotes: false,
        ),
        child: RefreshIndicator(
          onRefresh: () async => refreshUserPlaylistsFromSpotify(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: UserInfo(),
                ),
                FutureBuilder<List<Playlist>>(
                  future: _listMergedPlaylists,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return snapshot.data!.isEmpty
                              ? Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Text(
                                        S.of(context).nothingHereForNow,
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Scrollbar(
                                      trackVisibility: true,
                                      thickness: 1.0,
                                      child: ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          var p = snapshot.data![index];
                                          return Dismissible(
                                            key: Key(p.name + DateTime.now().millisecondsSinceEpoch.toString()),
                                            direction: DismissDirection.horizontal,
                                            confirmDismiss: (DismissDirection direction) async {
                                              return await showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(S.of(context).confirm),
                                                    content: RichText(
                                                      text: TextSpan(
                                                        style: Theme.of(context).textTheme.bodyMedium,
                                                        text: S.of(context).areYouSureYouWishToDelete_start,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: p.name,
                                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          TextSpan(text: S.of(context).areYouSureYouWishToDelete_end),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () => Navigator.of(context).pop(false),
                                                        child: Text(S.of(context).cancel),
                                                      ),
                                                      TextButton(
                                                        onPressed: () => Navigator.of(context).pop(true),
                                                        child: Text(S.of(context).delete),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            secondaryBackground: Container(
                                              color: Colors.red,
                                              padding: const EdgeInsets.only(right: 10.0),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            background: Container(
                                              color: Colors.red,
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onDismissed: (direction) {
                                              _removeMergedPlaylist(index);
                                            },
                                            child: GestureDetector(
                                              onTap: () async {
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(p.name),
                                                        contentPadding:
                                                            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            ListTile(
                                                              visualDensity: VisualDensity.compact,
                                                              contentPadding: const EdgeInsets.all(4.0),
                                                              dense: true,
                                                              onTap: () async {
                                                                await Workmanager().registerOneOffTask(
                                                                  DateTime.now().millisecond.toString(),
                                                                  WorkManagerHelper.TASK_DO_MERGING_NOW_SPECIFIC,
                                                                  inputData: {
                                                                    "playlistId": p.playlistId,
                                                                    "notificationChannelId":
                                                                        NotificationsHelper.CHANNEL_KEY_MERGING_RESULTS,
                                                                    "notificationChannelName":
                                                                        S.of(context).channelNameMergingResults,
                                                                    "successTitle":
                                                                        S.of(context).notificationSuccessTitle,
                                                                    "successMessage": S
                                                                        .of(context)
                                                                        .notificationPlaylistUpdatedSuccessfully(
                                                                            p.name),
                                                                    "failureTitle":
                                                                        S.of(context).notificationFailureTitle,
                                                                    "failureMessage":
                                                                        S.of(context).notificationMergingFailed,
                                                                    "notificationInProgressChannelId":
                                                                        NotificationsHelper.CHANNEL_KEY_IN_PROGRESS,
                                                                    "notificationInProgressChannelName":
                                                                        S.of(context).notificationInProgressChannelName,
                                                                    "notificationInProgressMessage":
                                                                        S.of(context).notificationInProgressMessage,
                                                                  },
                                                                );
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(S
                                                                        .of(context)
                                                                        .anUpdateToYourPlaylistIsBeingMadeInSpotify(1)),
                                                                  ),
                                                                );
                                                                Navigator.pop(context);
                                                              },
                                                              title: Text(
                                                                S.of(context).updateThisInSpotify,
                                                                style: Theme.of(context).textTheme.bodyMedium,
                                                              ),
                                                              leading: const Icon(
                                                                Icons.call_merge,
                                                                size: 30.0,
                                                              ),
                                                            ),
                                                            ListTile(
                                                              visualDensity: VisualDensity.compact,
                                                              contentPadding: const EdgeInsets.all(4.0),
                                                              dense: true,
                                                              onTap: () async {
                                                                Navigator.pop(context);
                                                                launchUrlString(p.playUrl);
                                                              },
                                                              title: Text(
                                                                S.of(context).openInSpotify,
                                                                style: Theme.of(context).textTheme.bodyMedium,
                                                              ),
                                                              leading: const Icon(Icons.play_circle_fill_outlined),
                                                            ),
                                                            ListTile(
                                                              visualDensity: VisualDensity.compact,
                                                              contentPadding: const EdgeInsets.all(4.0),
                                                              dense: true,
                                                              onTap: () async {
                                                                await showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return AlertDialog(
                                                                      title: Text(S.of(context).confirm),
                                                                      content: RichText(
                                                                        text: TextSpan(
                                                                          style: Theme.of(context).textTheme.bodyMedium,
                                                                          text: S
                                                                              .of(context)
                                                                              .areYouSureYouWishToDelete_start,
                                                                          children: <TextSpan>[
                                                                            TextSpan(
                                                                              text: p.name,
                                                                              style: const TextStyle(
                                                                                  fontWeight: FontWeight.bold),
                                                                            ),
                                                                            TextSpan(
                                                                                text: S
                                                                                    .of(context)
                                                                                    .areYouSureYouWishToDelete_end),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          onPressed: () => Navigator.of(context).pop(),
                                                                          child: Text(S.of(context).cancel),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () async {
                                                                            await _removeMergedPlaylist(index);
                                                                            Navigator.popUntil(
                                                                                context,
                                                                                (Route<dynamic> route) =>
                                                                                    route.isFirst);
                                                                          },
                                                                          child: Text(S.of(context).delete),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              title: Text(
                                                                S.of(context).deleteThisMergingRule,
                                                                style: Theme.of(context).textTheme.bodyMedium,
                                                              ),
                                                              leading: const Icon(Icons.delete),
                                                            ),
                                                            ListTile(
                                                              visualDensity: VisualDensity.compact,
                                                              contentPadding: const EdgeInsets.all(4.0),
                                                              dense: true,
                                                              onTap: () async {
                                                                Navigator.pop(context);
                                                                await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => MergingDefinition(
                                                                      editingPlaylistId: p.playlistId,
                                                                    ),
                                                                  ),
                                                                );
                                                                _updateListMergedPlaylists();
                                                              },
                                                              title: Text(
                                                                S.of(context).modifyThisMergingRule,
                                                                style: Theme.of(context).textTheme.bodyMedium,
                                                              ),
                                                              leading: const Icon(Icons.edit_rounded),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: ListTile(
                                                title: Text(p.name),
                                                contentPadding: const EdgeInsets.only(left: 16.0, right: 0.0),
                                                trailing: const Icon(
                                                  Icons.more_vert,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                        } else if (snapshot.hasError) {
                          return Expanded(
                            child: Center(
                              child: Text(snapshot.error.toString()),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text(
                                  S.of(context).nothingHereForNow,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          );
                        }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
