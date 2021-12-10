import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/screens/profile/profile_screen.dart';
import 'package:hunde_zunder/services/auth/authentication_service.dart';
import 'package:hunde_zunder/services/auth/firebase_provider_configurations.dart';
import 'package:provider/src/provider.dart';

import 'pages/pet_page/pet_page.dart';
import 'pages/swipe_page/swipe_page.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, ProfileScreen.routeName),
            icon: Icon(Icons.person),
          )
        ],
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Drawer(
          child: PetPage(),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              child: Text("HomeScreen"),
              onTap: () => Navigator.of(context).pushReplacementNamed(
                HomeScreen.routeName,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Logout"),
            ),
            Expanded(
              child: SwipePage(),
            ),
          ],
        ),
      ),
    );
  }
}
