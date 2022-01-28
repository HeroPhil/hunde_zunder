import 'package:flutter/material.dart';

class UiTheme {
  static final primaryColor = Colors.orange;
  static final secondaryColor = Colors.orangeAccent;
  static final primaryColorScheme =
      ColorScheme.fromSwatch(primarySwatch: primaryColor);

  static final lightTheme = ThemeData.from(
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
  ).copyWith(
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static final darkTheme = ThemeData.from(
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
  ).copyWith(
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
