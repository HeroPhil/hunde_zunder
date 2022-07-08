import 'dart:convert';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:json_annotation/json_annotation.dart';

class BoolConverter implements JsonConverter<bool?, int?> {
  const BoolConverter();

  @override
  bool? fromJson(int? json) {
    return boolFromInt(json);
  }

  @override
  int? toJson(bool? bool) {
    return boolToInt(bool);
  }

  static bool? boolFromInt(int? done) => done != null ? done == 1 : null;

  static int? boolToInt(bool? done) => done != null ? (done ? 1 : 0) : null;
}
