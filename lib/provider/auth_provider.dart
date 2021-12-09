import 'package:flutter/cupertino.dart';
import 'package:hunde_zunder/services/auth/authentication_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthenticationService authenticationService;
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  AuthProvider({
    required this.authenticationService,
  });

  void submit() async {
    print("submitting...");
    if (formKey.currentState?.validate() ?? false) {
      print("validated");
      formKey.currentState!.save();
      print("saved to globalKey!");
      await authenticationService.signInEmailAndPassword(
        email: email!,
        password: password!,
      );
      print("auth finished!");
    }
  }
}
