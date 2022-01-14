import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';

enum SwipeResult {
  hate,
  love,
}

class SwipePageProvider with ChangeNotifier {
  // dependencies
  final PetProvider petProvider;

  List<Pet> loadedPets = [];

  SwipePageProvider({required this.petProvider}) {
    while (loadedPets.length < 3) {
      loadedPets.add(petProvider.nextForeignPet);
      print(loadedPets.map((e) => e.name).toList());
    }
  }

  void swipeCard(SwipeResult result) {
    if (result == SwipeResult.love) {
      // make love
      print("making love");
    } else {
      // kick in ass
      print("kicking in ass");
    }

    // either Way, remove from stack
    loadedPets.removeAt(0);

    // load new pet
    loadedPets.add(petProvider.nextForeignPet);

    print(loadedPets.map((e) => e.name).toList());

    notifyListeners();
  }
}
