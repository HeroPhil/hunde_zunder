import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/external/hero_dialog_route.dart';
import 'package:hunde_zunder/pages/pet_detail/pet_detail_page.dart';
import 'package:hunde_zunder/provider/auth_provider.dart';
import 'package:hunde_zunder/provider/match_provider.dart';
import 'package:hunde_zunder/provider/mock_provider.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';
import 'package:hunde_zunder/screens/auth/auth_screen.dart';
import 'package:hunde_zunder/screens/crash/crash_screen.dart';
import 'package:hunde_zunder/screens/home/home_screen.dart';
import 'package:hunde_zunder/screens/home/home_screen_provider.dart';
import 'package:hunde_zunder/screens/home/pages/match/match_page_provider.dart';
import 'package:hunde_zunder/screens/home/pages/pet/pet_page_provider.dart';
import 'package:hunde_zunder/screens/home/pages/swipe/swipe_page_provider.dart';
import 'package:hunde_zunder/screens/loading/loading_screen.dart';
import 'package:hunde_zunder/screens/profile/profile_screen.dart';

import 'package:hunde_zunder/screens/sign_up/sign_up_screen.dart';
import 'package:hunde_zunder/services/authentication_service.dart';
import 'package:provider/provider.dart';

abstract class AppRouter {
  static PageRoute generateRoute(RouteSettings routeSettings) {
    late final Map<String, dynamic> arguments;
    try {
      arguments = routeSettings.arguments as Map<String, dynamic>;
    } catch (e) {
      arguments = {};
    }

    switch (routeSettings.name) {
      case PetDetailPage.routeName:
        return HeroDialogRoute(
          builder: (context) {
            return PetDetailPage(
              pet: arguments["pet"],
            );
          },
          settings: routeSettings,
        );
    }

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

        final _petProvider = context.read<PetProvider>();
        final _matchProvider = context.read<MatchProvider>();

        switch (routeSettings.name) {
          case HomeScreen.routeName:
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<HomeScreenProvider>(
                  create: (context) => HomeScreenProvider(),
                ),
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
                ChangeNotifierProvider<MatchPageProvider>(
                  create: (context) => MatchPageProvider(
                    matchProvider: _matchProvider,
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
