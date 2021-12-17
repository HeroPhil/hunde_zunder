// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:crypto/crypto.dart';
// import 'dart:convert';
// import 'dart:math';

// ///Service for managing all Firebase Authentication
// ///
// ///Contains all methods for User Management like signIn, signOut etc.
// ///Provides a [User] Stream to the MaterialApp, which holds the currently logged in User.
// ///Provides [laodingState] for changes in the Login-UI.
// @deprecated
// class AuthenticationService with ChangeNotifier {
//   final _db = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth;
//   final _googleSignIn = GoogleSignIn(
//     clientId:
//         "929360975704-u1455gni3shrfkptvmrjaslhn8npmrfs.apps.googleusercontent.com",
//   );
//   var _isLoading = 0;

//   AuthenticationService(this._firebaseAuth);

//   ///Returns true if an Authentication Process is in progress. Usable for a loading spinner etc.
//   bool get loadingState => _isLoading > 0;

//   ///Emits the current Firebase User as a [User] or [Null] if no User is signed in
//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

//   ///Logs in a User with the given [email] and [password]
//   ///
//   ///Returns ["Login erfolgreich"], if the login was successful, or an error Message if not
//   Future<String> signInEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       _isLoading++;
//       notifyListeners();
//       UserCredential userCredential =
//           await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return "Login erfolgreich";
//     } on FirebaseAuthException catch (e) {
//       notifyListeners();
//       return handleErrors(e);
//     } catch (e) {
//       print(e);
//       return "unknown error";
//     } finally {
//       _isLoading--;
//     }
//   }

//   ///Creates a User with the given [email] and [password]
//   ///
//   ///Returns ["Registrierung erfolgreich"], if the login was successful, or an error Message if not
//   Future<String> signUpEmailAndPassword({
//     required String email,
//     required String password,
//     required String userName,
//   }) async {
//     try {
//       _isLoading++;
//       notifyListeners();
//       UserCredential userCredential =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       updateUserData(
//         uid: userCredential.user!.uid,
//         email: userCredential.user!.email!,
//         userName: userName,
//         isSocialLogin: false,
//       );

//       return "Registrierung erfolgreich";
//     } on FirebaseAuthException catch (e) {
//       notifyListeners();
//       return handleErrors(e);
//     } catch (e) {
//       print(e);
//       return "unknown error";
//     } finally {
//       _isLoading--;
//     }
//   }

//   ///Authenticates a User in using [GoogleSignIn]
//   ///
//   ///Returns ["Registrierung erfolgreich"], if the login was successful, or an error Message if not
//   Future<String?> googleSignIn() async {
//     try {
//       //Interactive Sign in Process Start
//       GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       //Token after GoogleSignIn
//       GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       UserCredential _authResult =
//           await _firebaseAuth.signInWithCredential(credential);

//       final user = _authResult.user;
//       User currentUser = _firebaseAuth.currentUser!;

//       assert(currentUser.uid == user!.uid);

//       updateUserData(
//         uid: user!.uid,
//         email: user.email!,
//         userName: user.displayName!,
//         isSocialLogin: true,
//       );

//       return "Google Sign in Erfolgreich";
//     } on FirebaseAuthException catch (e) {
//       return handleErrors(e);
//     } catch (e) {
//       print(e);
//     }
//   }

//   ///Authenticates a User in using [SignInWithApple]
//   ///
//   ///Returns ["Registrierung erfolgreich"], if the login was successful, or an error Message if not
//   Future<String?> appleSignIn() async {
//     try {
//       final rawNonce = generateNonce();
//       final nonce = sha256ofString(rawNonce);

//       // Request credential for the currently signed in Apple account.
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//         nonce: nonce,
//       );

//       // Create an `OAuthCredential` from the credential returned by Apple.
//       final oauthCredential = OAuthProvider("apple.com").credential(
//         idToken: appleCredential.identityToken,
//         rawNonce: rawNonce,
//       );

//       // Sign in the user with Firebase. If the nonce we generated earlier does
//       // not match the nonce in `appleCredential.identityToken`, sign in will fail.
//       final UserCredential _authResult =
//           await _firebaseAuth.signInWithCredential(oauthCredential);

//       final user = _authResult.user!;
//       User currentUser = _firebaseAuth.currentUser!;

//       assert(currentUser.uid == user.uid);

//       final givenName = appleCredential.givenName;
//       final familyName = appleCredential.familyName;

//       var username;

//       //TODO: Debug UserName Situation

//       //Give the User a Username
//       if (givenName != null) {
//         username = givenName;
//       } else if (familyName != null) {
//         username = familyName;
//       } else if (user.displayName != null) {
//         username = user.displayName;
//       } else {
//         username = "anonym";
//       }

//       updateUserData(
//         uid: user.uid,
//         email: user.email!,
//         userName: username,
//         isSocialLogin: true,
//       );

//       return "Apple Sign in Erfolgreich";
//     } on FirebaseAuthException catch (e) {
//       return handleErrors(e);
//     } catch (e) {
//       print(e);
//     }
//   }

//   ///Signs out the current User
//   Future<void> signOut() async {
//     try {
//       if (await _googleSignIn.isSignedIn()) {
//         await _googleSignIn.disconnect();
//       }
//     } catch (e) {
//       print("google sign out error!");
//     }
//     await _firebaseAuth.signOut();
//   }

//   ///Handles [FirebaseAuthException] and returns a user friendly String containing the error message
//   String handleErrors(FirebaseAuthException exception) {
//     switch (exception.code) {
//       case "network-request-failed":
//         return "Bitte überprüfe deine Verbindung";

//       case "requires-recent-login":
//         return "Bitte logge dich erneut ein.";

//       case "ERROR_EMAIL_ALREADY_IN_USE":
//       case "email-already-in-use":
//         return "E-Mail bereits vergeben.";

//       case "ERROR_WRONG_PASSWORD":
//       case "wrong-password":
//         return "Falsche E-Mail oder Passwort.";

//       case "ERROR_USER_NOT_FOUND":
//       case "user-not-found":
//         return "Kein User gefunden.";

//       case "ERROR_USER_DISABLED":
//       case "user-disabled":
//         return "User deaktiviert.";

//       case "ERROR_TOO_MANY_REQUESTS":
//       case "operation-not-allowed":
//         return "Zu viele Login Anfragen.";

//       case "ERROR_OPERATION_NOT_ALLOWED":
//       case "operation-not-allowed":
//         return "Server Fehler, bitte später erneut versuchen.";

//       case "ERROR_INVALID_EMAIL":
//       case "invalid-email":
//         return "Keine gültige E-Mail.";

//       default:
//         return "Login gescheitert. Bitte versuche es noch einmal.";
//     }
//   }

//   ///Sends an E-Mail to the given [email] to reset the password for the Account.
//   ///
//   ///Returns ["Email gesendet"] when successful, or an Error Message if not
//   Future<String?> resetPassword({required String email}) async {
//     try {
//       await _firebaseAuth.sendPasswordResetEmail(email: email);
//       return "Email gesendet!";
//     } on FirebaseAuthException catch (e) {
//       return handleErrors(e);
//     } catch (e) {
//       print(e);
//     }
//   }

//   ///Creates a User Document on SignUp
//   ///
//   ///When a Social Login([GoogleSignIn, SignInWithApple]) is used, the function checks if the user already exists.
//   ///If so, the function doesnt update the document, so that the userName oder Email doesnt get changed.
//   ///When the User doesnt exist, the function uses the given [userName] from [appleSignIn] or the displayName from [googleSignIn].
//   ///If no Social Login is used, the function creates a userDocument with the given parameters.
//   void updateUserData({
//     required String uid,
//     required String email,
//     required String userName,
//     required bool isSocialLogin,
//   }) async {
//     DocumentReference ref = _db.collection('users').doc(uid);

//     if (isSocialLogin) {
//       final snap = await ref.get();

//       if (!snap.exists) {
//         await ref.set(
//           {
//             'uid': uid,
//             'email': email,
//             'username': userName,
//           },
//         );
//       }
//     } else {
//       await ref.set(
//         {
//           'uid': uid,
//           'email': email,
//           'userName': userName,
//         },
//       );
//     }
//   }

//   //only for appleSignIn
//   String sha256ofString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }

//   //only for appleSignIn
//   String generateNonce([int length = 32]) {
//     final charset =
//         '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//     final random = Random.secure();
//     return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//         .join();
//   }

//   /// Deletes the current User from Firebase
//   Future<String> deleteUser() async {
//     try {
//       _isLoading++;
//       // await _firebaseAuth.currentUser?.delete(); // TODO remove (see below)
//       final result = await FirebaseFunctions.instanceFor(region: 'europe-west1')
//           .httpsCallable("deleteUser")
//           .call() as bool;
//       print("CF done: $result");
//       if (result) {
//         signOut();
//         return "Account gelöscht!";
//       }
//       throw (result);
//     } catch (e) {
//       return "Löschen fehlgeschlagen, bitte an den Support wenden!";
//     } finally {
//       _isLoading--;
//     }
//   }
// }
