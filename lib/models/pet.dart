import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class Pet {
  // Mocked
  late final String id;
  final String name;
  final Uint8List image;

  Pet({
    required this.name,
    required this.image,
  }) {
    id = Uuid().v4();
  }
}
