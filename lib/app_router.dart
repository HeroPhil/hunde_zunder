import 'package:flutter/material.dart';
import 'package:hunde_zunder/screens/home/pages/chat/chat_page_provider.dart';
import 'package:hunde_zunder/services/backend_service.dart';
import 'package:provider/provider.dart';

import 'external/hero_dialog_route.dart';
import 'pages/pet_detail/pet_detail_page.dart';
import 'pages/pet_detail/pet_detail_page_provider.dart';
import 'provider/match_provider.dart';
import 'provider/pet_provider.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/auth/auth_screen_provider.dart';
import 'screens/crash/crash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/home_screen_provider.dart';
import 'screens/home/pages/match/match_page_provider.dart';
import 'screens/home/pages/pet/pet_page_provider.dart';
import 'screens/home/pages/swipe/swipe_page_provider.dart';
import 'screens/loading/loading_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

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
          settings: routeSettings,
          builder: (context) {
            return ChangeNotifierProvider<PetDetailPageProvider>(
              create: (context) => PetDetailPageProvider(
                petProvider: context.read<PetProvider>(),
                pet: arguments['pet'],
              )..init(),
              child: PetDetailPage(),
            );
          },
        );
    }

    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) {
        switch (routeSettings.name) {
          case SignUpScreen.routeName:
            return SignUpScreen();
          case AuthScreen.routeName:
            return ChangeNotifierProvider<AuthScreenProvider>(
              create: (_) => AuthScreenProvider(),
              child: AuthScreen(),
            );
          case LoadingScreen.routeName:
            return LoadingScreen();
        }

        final _backendService = context.read<BackendService>();
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
                    backendService: _backendService,
                    petProvider: _petProvider,
                  ),
                ),
                ChangeNotifierProvider<MatchPageProvider>(
                  create: (context) => MatchPageProvider(
                    matchProvider: _matchProvider,
                  ),
                ),
                ChangeNotifierProvider<ChatPageProvider>(
                  create: (context) => ChatPageProvider(
                    petProvider: _petProvider,
                    // matchProvider: _matchProvider,
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
