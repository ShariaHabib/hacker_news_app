import 'package:flutter/material.dart';

// add a light theme and a dark theme
class ThemeService extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get theme => _themeData;

  void switchTheme() {
    if (_themeData == ThemeData.light()) {
      _themeData = ThemeData.dark();
    } else {
      _themeData = ThemeData.light();
    }
    print("CJANFE");
    notifyListeners();
  }
}
