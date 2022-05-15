import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

class ImageConverter implements JsonConverter<Uint8List, List<int>> {
  const ImageConverter();

  @override
  Uint8List fromJson(List<int> json) {
    return Uint8List.fromList(json);
  }

  @override
  List<int> toJson(Uint8List image) {
    return image.toList();
  }
}
