import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

class ImageConverter implements JsonConverter<Uint8List, String> {
  const ImageConverter();

  @override
  Uint8List fromJson(String json) {
    return Uint8List.fromList(base64Decode(json));
  }

  @override
  String toJson(Uint8List image) {
    return base64Encode(image.toList());
  }
}
