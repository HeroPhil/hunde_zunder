import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';

import 'package:subscribed_stream/subscribed_stream.dart';

/// Service for managing all Firebase Authentication
///
/// Provides a [User] Stream to the MaterialApp, which holds the currently logged in User.
class FirebaseAuthService with ChangeNotifier {
  static const firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyDMAsGwGnGGnB6CCvFJyMPEY7H8hHXiZuc",
    authDomain: "hunde-zunder.firebaseapp.com",
    projectId: "hunde-zunder",
    storageBucket: "hunde-zunder.appspot.com",
    messagingSenderId: "929360975704",
    appId: "1:929360975704:web:675973e2085a8342b9372d",
  );

  static const providerConfigurations = [
    EmailProviderConfiguration(),
    GoogleProviderConfiguration(
      clientId:
          "929360975704-u1455gni3shrfkptvmrjaslhn8npmrfs.apps.googleusercontent.com",
    ),
  ];

  late final SubscribedStream<User?> _subscribedUserStream;

  late final FirebaseAuth _firebaseAuth;

  FirebaseAuthService() {
    _firebaseAuth = FirebaseAuth.instance;
    _subscribedUserStream = SubscribedStream<User?>(
      stream: _firebaseAuth.authStateChanges(),
      onStreamEvent: (data, previous, _) {
        print("New User: $data");
        notifyListeners();
        return data;
      },
    );
  }

  ///Emits the current Firebase User as a [User] or [Null] if no User is signed in
  Stream<User?> get authStateChanges => _subscribedUserStream.stream;

  ///Signs out the current User
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> getBearerToken() async {
    return await _subscribedUserStream.latestValue?.getIdToken();
  }
}
