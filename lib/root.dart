import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/app.dart';
import 'package:hunde_zunder/services/auth/authentication_service.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationService>(
          create: (context) => AuthenticationService(FirebaseAuth.instance),
        ),
        // TODO use Model to broadcast currentUser
        StreamProvider<User?>(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      builder: (context, _) {
        final User? user = context.watch<User?>();

        // register Global Provider here

        if (user != null) {
          // register Global Provider which are dependend on the currentUser here

        }

        return App();
      },
    );
  }
}
