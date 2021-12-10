import 'package:flutter/material.dart';
import 'package:hunde_zunder/services/auth/firebase_provider_configurations.dart';
import 'package:flutterfire_ui/auth.dart' as FireFlutter;

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FireFlutter.ProfileScreen(
      providerConfigs: FirebaseProviderConfigurations.providerConfigurations,
    );
  }
}
