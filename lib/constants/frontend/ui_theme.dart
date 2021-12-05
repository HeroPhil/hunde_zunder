import 'package:flutter/material.dart';

class UiTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.orange,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white70,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.orange,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black54,
  );
}
