import 'package:flutter/material.dart';

class UiTheme {
  static final _primaryColor = Colors.orange;
  static final _secondaryColor = Colors.pink;
  static final lightTheme = ThemeData.from(
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
    ),
  );

  static final darkTheme = ThemeData.from(
    colorScheme: ColorScheme.dark(
      primary: _primaryColor,
      secondary: _secondaryColor,
    ),
  );
}
