import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService extends ChangeNotifier {
  bool _isDarkTheme = false;

  ThemeData get theme => _isDarkTheme ? _darkTheme : _lightTheme;

  final ThemeData _lightTheme = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xFFFF7043), // Light deep orange
      primaryContainer: Color(0xFFFFAB91), // Light deep orange container
      secondary: Color(0xFFFFA726), // Light amber orange
      secondaryContainer: Color(0xFFFFCC80), // Light amber orange container
      tertiary: Color(0xFFFFB74D), // Light amber
      tertiaryContainer: Color(0xFFFFE0B2), // Light amber container
      appBarColor: Color(0xFFFF7043), // Light deep orange
      error: Color(0xFFD32F2F), // Red
    ),
    surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.lato().fontFamily,
  );

  final ThemeData _darkTheme = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xFFFF7043), // Light deep orange
      primaryContainer: Color(0xFFFFAB91), // Light deep orange container
      secondary: Color(0xFFFFA726), // Light amber orange
      secondaryContainer: Color(0xFFFFCC80), // Light amber orange container
      tertiary: Color(0xFFFFB74D), // Light amber
      tertiaryContainer: Color(0xFFFFE0B2), // Light amber container
      appBarColor: Color(0xFFFF7043), // Light deep orange
      error: Color(0xFFD32F2F), // Red
    ),
    surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
    blendLevel: 13,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.lato().fontFamily,
  );

  void switchTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
