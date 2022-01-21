import 'dart:typed_data';

import 'package:uuid/uuid.dart';

enum PetType {
  other,
  dog,
  cat,
  bird,
  fish,
}

enum PetGender {
  other,
  male,
  female,
}

class Pet {
  late final String id; // Mocked
  String name;
  Uint8List image;
  PetType type;
  PetGender gender;
  String? race;
  String? description;
  DateTime? birthday;

  Pet({
    required this.name,
    required this.image,
    this.type = PetType.other,
    this.gender = PetGender.other,
    this.race,
    this.description,
    this.birthday,
  }) : id = Uuid().v4();

  Pet.fromJson({
    required this.id,
    required Map<String, dynamic> json,
  })  : name = json["name"],
        image = Uint8List.fromList(json["image"]),
        type = PetType.values[json["type"] ?? 0],
        gender = PetGender.values[json["gender"] ?? 0],
        race = json["race"],
        description = json["description"],
        birthday = json["birthday"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["birthday"])
            : null;

  get asJson => {
        "name": name,
        "image": image,
        "type": PetType.values.indexOf(type),
        "gender": PetGender.values.indexOf(gender),
        if (race != null) "race": race,
        if (description != null) "description": description,
        if (birthday != null) "birthday": birthday!.millisecondsSinceEpoch,
      };
}
