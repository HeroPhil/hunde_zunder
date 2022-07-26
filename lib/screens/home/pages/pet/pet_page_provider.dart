import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../models/pet.dart';
import '../../../../provider/mock_provider.dart';
import '../../../../provider/pet_provider.dart';

class PetPageProvider with ChangeNotifier {
  final PetProvider petProvider;

  PetPageProvider({
    required this.petProvider,
  });

  List<Pet>? get pets {
    return petProvider.myPets;
  }
}
