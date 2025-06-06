import 'package:flutter/material.dart';
import 'package:wordle/themes/dark_mode.dart';
import 'package:wordle/themes/light_mode.dart';
import 'package:wordle/themes/night_mode.dart';

enum AppTheme { light, dark, night }

class ThemeProvider extends ChangeNotifier {
  AppTheme _currentTheme = AppTheme.light;

  ThemeData get themeData {
    switch (_currentTheme) {
      case AppTheme.dark:
        return darkMode;
      case AppTheme.night:
        return nightMode;
      case AppTheme.light:
        return lightMode;
    }
  }

  AppTheme get currentTheme => _currentTheme;

  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  String get currentUrl {
    if (_currentTheme == AppTheme.light) {
      return 'assets/asd.png';
    } else {
      return 'assets/asdwhite.png';
    }
  }
}
