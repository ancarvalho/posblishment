import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

ThemeData getTheme(String theme) {
  switch (theme) {
    case "dark-theme":
      return Themes.darkTheme;
    case "light-theme":
      return Themes.lightTheme;
    case "solarized-light-theme":
      return SolarizedTheme.solarizedLightTheme;
    case "solarized-dark-theme":
      return SolarizedTheme.solarizedDarkTheme;
    default:
      return Themes.darkTheme;
  }
}
