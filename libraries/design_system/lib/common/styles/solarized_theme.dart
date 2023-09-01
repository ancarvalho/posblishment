import 'package:flutter/material.dart';

import 'color_palettes.dart';

class SolarizedTheme {
  static ThemeData solarizedLightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: SolarizedColors.blue,
    scaffoldBackgroundColor: SolarizedColors.base3,
    cardColor: SolarizedColors.base2,
    canvasColor: SolarizedColors.base2,
    // buttonColor: SolarizedColors.blue,
    
    tabBarTheme: const TabBarTheme(
      labelColor: SolarizedColors.base3,
      unselectedLabelColor:SolarizedColors.base1 ,
      labelStyle: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: SolarizedColors.base0,
      toolbarTextStyle: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),

    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: SolarizedColors.yellow)
        .copyWith(background: SolarizedColors.base3),
  );

  static ThemeData solarizedDarkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: SolarizedColors.blue,
    scaffoldBackgroundColor: SolarizedColors.base03,
    tabBarTheme: const TabBarTheme(
      labelColor: SolarizedColors.base03,
      unselectedLabelColor:SolarizedColors.base01 ,
      labelStyle: TextStyle(
        color: SolarizedColors.base03,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: SolarizedColors.base00,
      toolbarTextStyle: TextStyle(
        color: SolarizedColors.base03,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    
    cardColor: SolarizedColors.base02,
    canvasColor: SolarizedColors.base02,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: SolarizedColors.yellow)
        .copyWith(background: SolarizedColors.base03),
  );
}
