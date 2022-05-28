import 'dart:convert';

import 'package:flutter/material.dart';
import 'firebase_auth_service.dart';
import 'package:http/http.dart' as http;

import 'dart:html';

enum RequestType {
  GET,
  POST,
  PUT,
  DELETE,
}

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
  // static final baseUrl = Uri(
  //   scheme: "https",
  //   host: "api.pet-connect.karottenkameraden.de",
  //   port: 443,
  //   path: "",
  // );
  static final baseUrl = Uri(
    scheme: "http",
    host: "petconnect-env.eba-mm7ehn6g.eu-central-1.elasticbeanstalk.com",
    port: 80,
    path: "",
  );

  final FirebaseAuthService firebaseAuthService;

  BackendService({
    required this.firebaseAuthService,
  });

  Future<Map<String, dynamic>?> callBackend({
    required RequestType requestType,
    String? endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headerParameters,
    Map<String, dynamic>? body,
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

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'origin': '${window.location.origin}',
      if (token != null) 'Authorization': 'Bearer $token',
      if (headerParameters != null) ...headerParameters,
    };

    late http.Response response;
    try {
      switch (requestType) {
        case RequestType.POST:
          print("posting to ${url.toString()}");
          response =
              await http.post(url, headers: headers, body: json.encode(body));
          break;
        case RequestType.PUT:
          print("putting to ${url.toString()}");
          response =
              await http.put(url, headers: headers, body: json.encode(body));
          break;
        case RequestType.DELETE:
          print("deleting from ${url.toString()}");
          response = await http.delete(url, headers: headers);
          break;
        default:
          print("getting from ${url.toString()}");
          response = await http.get(url, headers: headers);
          break;
      }
    } on http.ClientException catch (e) {
      print("http Client Exception error: $e");
      print(e);
      return null;
    }

    print("response(${response.statusCode}): ${response.body}");

    if (response.statusCode == 200) {
      return {"myPets": jsonDecode(response.body)}; //as Map<String, dynamic>;
    } else {
      print("http request failed: ${response.statusCode}");
    }
  }
}
