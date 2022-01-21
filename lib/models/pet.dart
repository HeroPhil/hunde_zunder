import 'dart:typed_data';

import 'package:uuid/uuid.dart';

enum PetType {
  dog,
  cat,
  bird,
  fish,
  other,
}

class Pet {
  late final String id; // Mocked
  String name;
  Uint8List image;
  PetType type;
  String? race;
  String? description;
  DateTime? birthday;

  Pet({
    required this.name,
    required this.image,
    this.type = PetType.other,
    this.race,
    this.description,
    this.birthday,
  }) : id = Uuid().v4();

  Pet.fromJson({
    required this.id,
    required Map<String, dynamic> json,
  })  : name = json["name"],
        image = Uint8List.fromList(json["image"]),
        type = PetType.values[json["type"] ?? 4],
        race = json["race"],
        description = json["description"],
        birthday = json["birthday"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["birthday"])
            : null;

  get asJson => {
        "name": name,
        "image": image,
        "type": PetType.values.indexOf(type),
        if (race != null) "race": race,
        if (description != null) "description": description,
        if (birthday != null) "birthday": birthday!.millisecondsSinceEpoch,
      };
}
