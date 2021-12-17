import 'package:flutter/material.dart';
import 'package:hunde_zunder/services/firebase_auth_service.dart';
import 'package:http/http.dart' as http;

class BackendService with ChangeNotifier {
  // static final url = "api.pet-connect.karottenkameraden.de";
  static final url = Uri.parse(
      "http://ec2-3-71-47-168.eu-central-1.compute.amazonaws.com:8080/public/debug");

  final FirebaseAuthService firebaseAuthService;

  BackendService({
    required this.firebaseAuthService,
  });

  void callBackend() async {
    final token = await firebaseAuthService.getBearerToken();

    if (token == null) {
      print("warning: no token for backend auth. Try to request without auth.");
    } else {
      print("token for backend auth: $token");
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    });

    print("response(${response.statusCode}): ${response.body}");
  }
}
