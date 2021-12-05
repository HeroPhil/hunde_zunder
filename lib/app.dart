import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/constants/frontend/ui_theme.dart';
import 'package:hunde_zunder/screens/auth/auth_screen.dart';
import 'package:hunde_zunder/screens/home/home_screen.dart';
import 'package:hunde_zunder/services/auth/authentication_service.dart';
import 'package:provider/src/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetConnect',
      theme: UiTheme.lightTheme,
      darkTheme: UiTheme.darkTheme,
      home: context.watch<User?>() != null ? HomeScreen() : AuthScreen(),
    );
  }
}
