import 'dart:convert';
import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import '../converter/image_converter.dart';
import 'package:uuid/uuid.dart';

import 'package:json_annotation/json_annotation.dart';

part 'pet.g.dart';

@JsonEnum()
enum PetType {
  other,
  dog,
  cat,
  bird,
  fish,
}

@JsonEnum()
enum PetGender {
  other,
  male,
  female,
}

@JsonSerializable()
@CopyWith()
class Pet {
  final int petID; // Mocked // ! does this remain a String?
  final String name;
  @ImageConverter()
  final Uint8List image;
  final PetType type;
  final PetGender gender;
  final String? race;
  final String? description;
  final DateTime? birthday;

  Pet({
    int? petID,
    required this.name,
    required this.image,
    this.type = PetType.other,
    this.gender = PetGender.other,
    this.race,
    this.description,
    this.birthday,
  }) : petID = petID ?? Uuid().v4().hashCode;

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  get toJson => _$PetToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Pet) {
      return petID == other.petID;
    }
    return false;
  }

  @override
  int get hashCode => petID.hashCode;
}
