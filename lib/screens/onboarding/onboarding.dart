// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:playlistmerger4spotify/generated/l10n.dart';
import 'package:playlistmerger4spotify/screens/my_home_page/my_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    var listPagesViewModel = [
      PageViewModel(
        title: S.of(context).welcome,
        body: S.of(context).appTitle,
        image: const Center(child: Icon(Icons.call_merge, color: Colors.green, size: 200.0)),
      ),
      PageViewModel(
        title: S.of(context).carefulexclamation,
        body: S.of(context).makeSureToChooseAPlaylistYouDontDirectlyAdd,
        image: Center(
          child: SizedBox(width: 250.0, child: Image.asset("assets/images/merging.png")),
        ),
      ),
      PageViewModel(
        title: S.of(context).pleaseLoginToSpotify,
        body: S.of(context).we_will_open_login,
        image: const Center(
          child: Icon(Icons.my_library_music_outlined, color: Colors.green, size: 200.0),
        ),
      ),
    ];

    return SafeArea(
      child: IntroductionScreen(
        pages: listPagesViewModel,
        next: const Icon(Icons.arrow_forward),
        done: Text(S.of(context).ok, style: const TextStyle(fontWeight: FontWeight.w600)),
        onDone: () async {
          final sharedPrefs = await SharedPreferences.getInstance();
          await sharedPrefs.setBool("isFirstTime", false);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyHomePage()));
        },
      ),
    );
  }
}
