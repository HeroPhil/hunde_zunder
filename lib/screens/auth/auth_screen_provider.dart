import 'package:flutter/material.dart';

class AuthScreenProvider with ChangeNotifier {
  late final GlobalKey animatedTextKey;

  AuthScreenProvider() {
    init();
  }

  void init() {
    animatedTextKey = GlobalKey();
  }
}
