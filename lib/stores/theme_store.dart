import 'package:flutter/material.dart';

enum AppThemes { system, light, dark }

class ThemeStore with ChangeNotifier {
  AppThemes _theme = AppThemes.system;
  AppThemes get theme => _theme;

  void setTheme(AppThemes newTheme) {
    _theme = newTheme;
    notifyListeners();
  }
}
