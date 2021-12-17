import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';

/// Service for managing all Firebase Authentication
///
/// Provides a [User] Stream to the MaterialApp, which holds the currently logged in User.
class FirebaseAuthService with ChangeNotifier {
  static final providerConfigurations = [
    EmailProviderConfiguration(),
    GoogleProviderConfiguration(
      clientId:
          "929360975704-u1455gni3shrfkptvmrjaslhn8npmrfs.apps.googleusercontent.com",
    ),
  ];

  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  ///Emits the current Firebase User as a [User] or [Null] if no User is signed in
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  ///Signs out the current User
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
