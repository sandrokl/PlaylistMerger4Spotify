import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/helpers/work_manager_helper.dart';
import 'package:playlistmerger4spotify/screens/my_home_page/my_home_page.dart';
import 'package:playlistmerger4spotify/screens/onboarding/onboarding.dart';
import 'package:playlistmerger4spotify/store/spotify_user_store.dart';
import 'package:playlistmerger4spotify/store/theme_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'generated/l10n.dart';

late bool isFirstTime;

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(WorkManagerHelper().handleTaskRequest);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(callbackDispatcher);

  final sharedPrefs = await SharedPreferences.getInstance();
  isFirstTime = sharedPrefs.getBool("isFirstTime") ?? true;

  runApp(
    MultiProvider(
      providers: [
        Provider<ThemeStore>(
          create: (_) => ThemeStore(),
        ),
        Provider<SpotifyUserStore>(
          create: (_) => SpotifyUserStore(),
        ),
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (_, db) => db.close(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeStore = Provider.of<ThemeStore>(context);

    return Observer(
      builder: (context) {
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.green,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.green,
          ),
          themeMode: themeStore.theme.name == "dark"
              ? ThemeMode.dark
              : (themeStore.theme.name == "light" ? ThemeMode.light : ThemeMode.system),
          home: isFirstTime ? const Onboarding() : const MyHomePage(),
        );
      },
    );
  }
}
