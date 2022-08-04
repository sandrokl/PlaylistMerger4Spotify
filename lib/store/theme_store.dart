// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStoreBase with _$ThemeStore;

enum AppThemes { system, light, dark }

abstract class _ThemeStoreBase with Store {
  @observable
  AppThemes theme = AppThemes.system;

  @action
  void setTheme(AppThemes newTheme) {
    theme = newTheme;
  }
}
