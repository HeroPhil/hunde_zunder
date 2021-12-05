import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/app.dart';
import 'package:hunde_zunder/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDMAsGwGnGGnB6CCvFJyMPEY7H8hHXiZuc",
        authDomain: "hunde-zunder.firebaseapp.com",
        projectId: "hunde-zunder",
        storageBucket: "hunde-zunder.appspot.com",
        messagingSenderId: "929360975704",
        appId: "1:929360975704:web:675973e2085a8342b9372d"),
  );
  runApp(const Root());
}
