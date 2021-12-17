import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/app.dart';
import 'package:hunde_zunder/root.dart';
import 'package:hunde_zunder/services/firebase_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseAuthService.firebaseOptions,
  );
  runApp(const Root());
}
