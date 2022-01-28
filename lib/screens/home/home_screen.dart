import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hunde_zunder/constants/frontend/ui_theme.dart';
import 'package:hunde_zunder/screens/home/home_screen_provider.dart';
import 'package:hunde_zunder/screens/home/pages/match/match_page.dart';
import 'package:hunde_zunder/screens/home/pages/pet/pet_page.dart';
import 'package:hunde_zunder/screens/home/pages/swipe/swipe_page.dart';
import 'package:hunde_zunder/screens/profile/profile_screen.dart';
import 'package:hunde_zunder/services/authentication_service.dart';
import 'package:hunde_zunder/services/backend_service.dart';
import 'package:hunde_zunder/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:res_builder/responsive.dart' as rb;

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<HomeScreenProvider>(
      builder: (context, homeScreenProvider, _) => Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
          border: Border.symmetric(),
          middle: GestureDetector(
            onTap: () => Navigator.of(context)
              ..popUntil((route) => route.isFirst)
              ..pushReplacementNamed(HomeScreen.routeName),
            child: Text(
              'Pet Connect',
              style: theme.textTheme.headline3!.copyWith(
                color: UiTheme.primaryColor,
              ),
            ),
          ),
          trailing: Builder(
            builder: (context) {
              final user = context.read<User>();
              final label =
                  user.displayName ?? user.email ?? "Who the fuck are u?";
              return TextButton.icon(
                label: Text(
                  rb.Responsive.value<String>(
                    context: context,
                    onMobile: "",
                    onTablet: label,
                  ),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
                icon: const Icon(Icons.person),
              );
            },
          ),
        ),
        body: rb.Responsive.withShared<List<Widget>>(
          share: [
            const PetPage(),
            const SwipePage(),
            const MatchPage(),
          ],
          onDesktop: (context, children) => Row(
            children: children
                .map((child) => Expanded(
                      child: child,
                    ))
                .toList(),
          ),
          onMobile: (context, children) => PageView(
            controller: homeScreenProvider.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
        ),
        bottomNavigationBar: rb.Responsive.isMobile(context)
            ? BottomNavigationBar(
                currentIndex: (homeScreenProvider.pageController.hasClients
                        ? homeScreenProvider.pageController.page ?? 1
                        : 1)
                    .toInt(),
                items: [
                  const BottomNavigationBarItem(
                    label: "MyPets",
                    icon: const Icon(Icons.home),
                  ),
                  const BottomNavigationBarItem(
                    label: "Search",
                    icon: const Icon(Icons.search),
                  ),
                  const BottomNavigationBarItem(
                    label: "Matches",
                    icon: const Icon(Icons.bolt),
                  ),
                ],
                onTap: (index) => homeScreenProvider.setPage(index),
              )
            : null,
      ),
    );
  }
}
