import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

ThemeData getTheme(ThemesOptions? theme) {
  switch (theme) {
    case ThemesOptions.dark:
      return Themes.darkTheme;
    case ThemesOptions.light:
      return Themes.lightTheme;
    case ThemesOptions.solarizedLight:
      return SolarizedTheme.solarizedLightTheme;
    case ThemesOptions.solarizedDark:
      return SolarizedTheme.solarizedDarkTheme;
    case null:
      return Themes.darkTheme;
  }
}
