import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hunde_zunder/models/pet.dart';
import 'package:hunde_zunder/provider/mock_provider.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';

class PetPageProvider with ChangeNotifier {
  final PetProvider petProvider;

  PetPageProvider({
    required this.petProvider,
  });

  List<Pet>? get pets {
    return petProvider.myPets;
  }
}
