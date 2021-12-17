import 'package:flutter/cupertino.dart';
import 'package:hunde_zunder/services/authentication_service.dart';
import 'package:hunde_zunder/services/firebase_auth_service.dart';

@deprecated
class AuthProvider with ChangeNotifier {
  final FirebaseAuthService firebaseAuthService;
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  AuthProvider({
    required this.firebaseAuthService,
  });

  // void submit() async {
  //   print("submitting...");
  //   if (formKey.currentState?.validate() ?? false) {
  //     print("validated");
  //     formKey.currentState!.save();
  //     print("saved to globalKey!");
  //     await firebaseAuthService.signInEmailAndPassword(
  //       email: email!,
  //       password: password!,
  //     );
  //     print("auth finished!");
  //   }
  // }
}
