import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  bool _isDarkTheme = false;

  ThemeData get theme => _isDarkTheme ? _darkTheme : _lightTheme;

  final ThemeData _lightTheme = ThemeData.light().copyWith(
    cardColor: Colors.orange[300],
  );

  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    cardColor: Colors.red[800],
  );

  void switchTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
