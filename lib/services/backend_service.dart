import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/services/firebase_auth_service.dart';
import 'package:http/http.dart' as http;

import 'dart:html';

class BackendService with ChangeNotifier {
  // static final url = "api.pet-connect.karottenkameraden.de";
  // static final url = Uri.parse(
  //     "http://ec2-3-71-47-168.eu-central-1.compute.amazonaws.com:8080/public/debug");
  // static final url = Uri(
  //   scheme: window.location.protocol,
  //   host: "ec2-3-71-47-168.eu-central-1.compute.amazonaws.com",
  //   port: 8080,
  //   path: "/public/debug",
  // );
  static final baseUrl = Uri(
    scheme: "https",
    host: "api.pet-connect.karottenkameraden.de",
    port: 443,
    path: "",
  );

  final FirebaseAuthService firebaseAuthService;

  BackendService({
    required this.firebaseAuthService,
  });

  dynamic callBackend({
    String? endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headerParameters,
  }) async {
    final url = baseUrl.replace(
      path: endpoint != null ? "${baseUrl.path}/$endpoint" : baseUrl.path,
      queryParameters: queryParameters,
    );

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
      if (headerParameters != null) ...headerParameters,
    });

    print("response(${response.statusCode}): ${response.body}");

    if (response.statusCode == 200) {
      return const JsonDecoder().convert(response.body);
    }
  }
}
