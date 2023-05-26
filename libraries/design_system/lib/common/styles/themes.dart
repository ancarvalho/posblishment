import 'package:flutter/material.dart';

import '../../../design_system.dart';

class Themes {
  // static ThemeData lightTheme = ThemeData(
  //   fontFamily: 'IBMPlexSans',
  //   primaryColor: ColorPalettes.lightPrimary,
  //   textSelectionTheme: TextSelectionThemeData(
  //     cursorColor: ColorPalettes.lightAccent,
  //   ),
  //   dividerColor: ColorPalettes.darkBG,
  //   scaffoldBackgroundColor: ColorPalettes.lightBG,
  //   appBarTheme: AppBarTheme(
  //     toolbarTextStyle: TextStyle(
  //       color: ColorPalettes.darkBG,
  //       fontSize: 18,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   colorScheme: ColorScheme.light(
  //     // primary: ColorPalettes.lightPrimary,
  //     background: ColorPalettes.lightBG,
  //   ),
  // );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    brightness: Brightness.dark,
    primaryColor: ColorPalettes.darkPrimary,
    dividerColor: ColorPalettes.lightPrimary,
    scaffoldBackgroundColor: ColorPalettes.darkBG,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalettes.darkAccent,
    ),
    appBarTheme: AppBarTheme(
      color: ColorPalettes.darkPrimary,
      toolbarTextStyle: TextStyle(
        color: ColorPalettes.lightBG,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    colorScheme: ColorScheme.dark(background: ColorPalettes.darkBG),
  );

  static ThemeData solarizedLightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: SolarizedColors.blue,
    scaffoldBackgroundColor: SolarizedColors.base3,
    cardColor: SolarizedColors.base2,
    canvasColor: SolarizedColors.base2,
    // buttonColor: SolarizedColors.blue,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: SolarizedColors.base02,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: SolarizedColors.base02,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: SolarizedColors.base02,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: SolarizedColors.base02,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: SolarizedColors.base02,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: SolarizedColors.base02,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: SolarizedColors.base01,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        color: SolarizedColors.base01,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: SolarizedColors.base02,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: SolarizedColors.base01,
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: SolarizedColors.base01,
        fontSize: 12,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: SolarizedColors.yellow)
        .copyWith(background: SolarizedColors.base3),
  );

   static ThemeData lightTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: SolarizedColors.blue,
    scaffoldBackgroundColor: SolarizedColors.base03,
    cardColor: SolarizedColors.base02,
    canvasColor: SolarizedColors.base02,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: SolarizedColors.base1,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        color: SolarizedColors.base1,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: SolarizedColors.base3,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: SolarizedColors.base1,
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        color: SolarizedColors.base03,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: SolarizedColors.base1,
        fontSize: 12,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: SolarizedColors.yellow)
        .copyWith(background: SolarizedColors.base03),
        
  );
}
