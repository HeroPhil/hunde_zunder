import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';
import 'package:hunde_zunder/provider/mock_provider.dart';

class PetProvider with ChangeNotifier {
  //dependencies
  final MockProvider mockProvider;

  // data
  List<Pet>? _myPets;

  PetProvider({
    required this.mockProvider,
  });

  List<Pet>? get myPets {
    _myPets ??= [
      Pet(
        name: 'Puppy',
        image: mockProvider.dogImages[0],
      ),
      Pet(
        name: 'Ralf',
        image: mockProvider.dogImages[1],
      ),
      Pet(
        name: 'Rudloff',
        image: mockProvider.dogImages[2],
      ),
    ];
    return _myPets;
  }

  Pet get nextForeignPet {
    return Pet(
      name: "Pet-${Random().nextInt(100)}",
      image: mockProvider
          .dogImages[Random().nextInt(mockProvider.dogImages.length)],
    );
  }
}
