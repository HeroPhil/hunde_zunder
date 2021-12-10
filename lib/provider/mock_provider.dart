import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MockProvider with ChangeNotifier {
  final List<Uint8List> dogImages = [];

  MockProvider() {
    _loadMockData();
  }

  Future _loadMockData() async {
    for (var i = 0; i <= 5; i++) {
      print('Loading image $i');
      dogImages.add(
        (await rootBundle.load('img/mocks/cute_dog$i.jpg'))
            .buffer
            .asUint8List(),
      );
    }
  }
}
