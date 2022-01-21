import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';

class PetDetailPageProvider with ChangeNotifier {
// dependencies
  PetProvider petProvider;

// state
  Pet pet;
  bool _editMode;
  late final GlobalKey<FormState> formKey;

  PetDetailPageProvider({
    Pet? pet,
    required this.petProvider,
  })  : this.pet = pet ??
            Pet(
              name: 'New Pet',
              image: Uint8List.fromList([]),
            ),
        _editMode = (pet == null);

  bool get editMode => _editMode;

  void toggleEditMode() {
    _editMode = !_editMode;
    notifyListeners();
  }

  void updatePetData(Pet Function(Pet) updatePet) {
    pet = updatePet(pet);
    notifyListeners();
  }

  // void submit() {
  //   if (formKey.currentState!.validate()) {
  //     formKey.currentState!.save();
  //     toggleEditMode();
  //     // TODO submit to Server
  //   }
  // }
}
