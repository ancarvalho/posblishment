import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../enums/themes.dart';

ThemeData getTheme(ThemesOptions theme) {
  switch (theme) {
    case ThemesOptions.dark:
      return Themes.darkTheme;
    case ThemesOptions.light:
      return Themes.lightTheme;
    case ThemesOptions.solarizedLight:
      return SolarizedTheme.solarizedLightTheme;
    case ThemesOptions.solarizedDark:
      return SolarizedTheme.solarizedDarkTheme;

  }
}
