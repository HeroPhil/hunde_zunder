import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';

class PetDetailPageProvider with ChangeNotifier {
  Pet pet;

  PetDetailPageProvider({
    Pet? pet,
  }) : this.pet = pet ??
            Pet(
              name: 'New Pet',
              image: Uint8List.fromList([]),
            );
}
