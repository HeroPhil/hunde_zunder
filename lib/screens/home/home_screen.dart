import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hunde_zunder/screens/home/pages/pet_page.dart';
import 'package:hunde_zunder/screens/home/pages/swipe_page.dart';
import 'package:hunde_zunder/services/auth/authentication_service.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
            Text("HomeScreen"),
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
