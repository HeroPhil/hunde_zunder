import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/constants/frontend/ui_assets.dart';
import 'package:hunde_zunder/models/pet.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';

class PetDetailPageProvider with ChangeNotifier {
// dependencies
  PetProvider petProvider;

// state
  bool initalized = false;
  Pet pet;
  bool _editMode;
  GlobalKey<FormState>? formKey;

  PetDetailPageProvider({
    Pet? pet,
    required this.petProvider,
  })  : this.pet = pet ??
            Pet(
              name: 'New Pet',
              image: UiAssets.defaultDogImage,
            ),
        _editMode = (pet == null) {}

  void init() {
    if (initalized) return;
    formKey = GlobalKey<FormState>(debugLabel: "petDetailForm");
    initalized = true;
  }

  @override
  void dispose() {
    super.dispose();
    formKey?.currentState?.dispose();
  }

  bool get editMode => _editMode;

  void toggleEditMode() {
    _editMode = !_editMode;
    notifyListeners();
  }

  void updatePetData(Pet Function(Pet) updatePet) {
    pet = updatePet(pet);
    notifyListeners();
  }

  void submit() {
    if (formKey?.currentState!.validate() ?? false) {
      formKey?.currentState!.save();
      toggleEditMode();
      // TODO submit to Server
    }
  }

  // /// returns a none null form key (must me set prior to use)
  // GlobalKey<FormState> get formKey => _formKey!;

  // /// if formKey is null, set to the given key
  // set formKey(GlobalKey<FormState> formKey) {
  //   _formKey ??= formKey;
  // }
}
