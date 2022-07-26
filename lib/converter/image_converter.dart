import 'dart:convert';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:json_annotation/json_annotation.dart';

class ImageConverter implements JsonConverter<Uint8List, String> {
  const ImageConverter();

  @override
  Uint8List fromJson(String json) {
    return Uint8List.fromList(base64Decode(json));
  }

  @override
  String toJson(Uint8List imageBytes) {
    final image = decodeImage(imageBytes);
    if (image == null) {
      throw Exception('Could not decode imageBytes');
    }
    final resizedImage = copyResize(image, width: 1024);
    final resizedImageBytes = encodeJpg(resizedImage, quality: 46);
    return base64Encode(resizedImageBytes.toList());
  }
}
