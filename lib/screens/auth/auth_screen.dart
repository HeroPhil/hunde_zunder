import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hunde_zunder/services/auth/authentication_service.dart';
import 'package:provider/src/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Auth Screen"),
            TextButton(
              onPressed: () {
                context.read<AuthenticationService>().signUpEmailAndPassword(
                      email: "hundefreund@mail.com",
                      password: "123456",
                      userName: "Hunde Freund",
                    );
              },
              child: Text("sign up"),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthenticationService>().signInEmailAndPassword(
                      email: "hundefreund@mail.com",
                      password: "123456",
                    );
              },
              child: Text("sign in"),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                context.read<AuthenticationService>().googleSignIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}
