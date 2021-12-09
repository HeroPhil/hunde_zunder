import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hunde_zunder/provider/auth_provider.dart';
import 'package:hunde_zunder/screens/sign_up/sign_up_screen.dart';
import 'package:hunde_zunder/services/auth/authentication_service.dart';
import 'package:hunde_zunder/services/auth/firebase_provider_configurations.dart';
import 'package:provider/src/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: Form(
    //       key: context.read<AuthProvider>().formKey,
    //       child: Column(
    //         children: [
    //           TextFormField(
    //             onSaved: (newValue) =>
    //                 context.read<AuthProvider>().email = newValue,
    //             validator: (value) {
    //               if (value?.isEmpty ?? true) {
    //                 return "Please enter email!";
    //               }
    //             },
    //             decoration: InputDecoration(
    //               labelText: "Email",
    //               hintText: "...@gmail.com",
    //               icon: Icon(Icons.person),
    //             ),
    //           ),
    //           TextFormField(
    //             obscureText: true,
    //             validator: (value) {
    //               if (value?.isEmpty ?? true) {
    //                 return "Please enter password!";
    //               }
    //             },
    //             onSaved: (newValue) =>
    //                 context.read<AuthProvider>().password = newValue,
    //             decoration: InputDecoration(
    //               labelText: "Password",
    //               icon: Icon(Icons.lock),
    //             ),
    //           ),
    //           OutlinedButton(
    //             onPressed: context.read<AuthProvider>().submit,
    //             child: Text("Sign In"),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pushNamed(SignUpScreen.routeName);
    //             },
    //             child: Text("Sign Up"),
    //           ),
    //           SignInButton(
    //             Buttons.Google,
    //             onPressed: () {
    //               context.read<AuthenticationService>().googleSignIn();
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return SignInScreen(
      providerConfigs: FirebaseProviderConfigurations.providerConfigurations,
    );
  }
}
