import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/provider/auth_provider.dart';
import 'package:hunde_zunder/provider/mock_provider.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';
import 'package:hunde_zunder/screens/auth/auth_screen.dart';
import 'package:hunde_zunder/screens/crash/crash_screen.dart';
import 'package:hunde_zunder/screens/home/home_screen.dart';
import 'package:hunde_zunder/screens/loading/loading_screen.dart';
import 'package:hunde_zunder/screens/profile/profile_screen.dart';

import 'package:hunde_zunder/screens/sign_up/sign_up_screen.dart';
import 'package:hunde_zunder/services/auth/authentication_service.dart';
import 'package:provider/provider.dart';

import 'screens/home/pages/pet_page/pet_page_provider.dart';
import 'screens/home/pages/swipe_page/swipe_page_provider.dart';

abstract class AppRouter {
  static MaterialPageRoute generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) {
        switch (routeSettings.name) {
          case SignUpScreen.routeName:
            return SignUpScreen();
          case AuthScreen.routeName:
            return AuthScreen();
          case LoadingScreen.routeName:
            return LoadingScreen();
        }

        final PetProvider _petProvider = context.read<PetProvider>();

        switch (routeSettings.name) {
          case HomeScreen.routeName:
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<PetPageProvider>(
                  create: (context) => PetPageProvider(
                    petProvider: _petProvider,
                  ),
                ),
                ChangeNotifierProvider<SwipePageProvider>(
                  create: (context) => SwipePageProvider(
                    petProvider: _petProvider,
                  ),
                ),
              ],
              builder: (context, _) {
                return HomeScreen();
              },
            );
          case ProfileScreen.routeName:
            return ProfileScreen();
          default:
            return CrashScreen();
        }
      },
    );
  }
}
