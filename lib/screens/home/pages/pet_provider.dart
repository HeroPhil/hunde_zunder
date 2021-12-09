import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';

class PetProvider with ChangeNotifier {
  List<Pet> get pets {
    return [
      Pet(
        name: 'Puppy',
        imageUrl: 'https://place.dog/300/200',
      ),
      Pet(
        name: 'Ralf',
        imageUrl: 'https://place.dog/300/200',
      ),
      Pet(
        name: 'Rudloff',
        imageUrl: 'https://place.dog/300/200',
      ),
    ];
  }
}
