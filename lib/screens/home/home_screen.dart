import 'package:flutter/material.dart';
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
          ],
        ),
      ),
    );
  }
}
