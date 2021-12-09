import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';
import 'package:hunde_zunder/screens/home/pages/widget/swipe_card.dart';

enum SwipeResult {
  hate,
  love,
}

class SwipePageProvider with ChangeNotifier {
  List<Pet> loadedPets = [];

  SwipePageProvider() {
    while (loadedPets.length < 3) {
      loadedPets.add(
        Pet(
          name: "Pet-${Random().nextInt(100)}",
          imageUrl: "https://place.dog/300/200",
        ),
      );
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
    loadedPets.add(
      Pet(
        name: "new-Pet-${Random().nextInt(100)}",
        imageUrl: "https://place.dog/300/200",
      ),
    );

    print(loadedPets.map((e) => e.name).toList());

    notifyListeners();
  }
}
