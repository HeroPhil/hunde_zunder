import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../constants/frontend/ui_assets.dart';
import '../../models/pet.dart';
import '../../provider/pet_provider.dart';

class PetDetailPageProvider with ChangeNotifier {
// dependencies
  PetProvider petProvider;

// state
  bool initialized = false;
  Pet pet;
  bool _editMode;
  bool _editablePet = false;
  GlobalKey<FormState>? formKey;

  PetDetailPageProvider({
    Pet? pet,
    required this.petProvider,
  })  : this.pet = pet ??
            Pet(
              name: 'New Pet',
              image: UiAssets.defaultDogImage,
            ),
        _editMode = (pet == null),
        _editablePet = (pet == null) {
    if (pet != null) {
      _checkForPetOwnership();
      petProvider.addListener(_checkForPetOwnership);
    }
  }

  void init() {
    if (initialized) return;
    formKey = GlobalKey<FormState>(debugLabel: "petDetailForm");
    initialized = true;
  }

  @override
  void dispose() {
    super.dispose();
    formKey?.currentState?.dispose();
    petProvider.removeListener(_checkForPetOwnership);
  }

  bool get editMode => _editablePet && _editMode;

  bool get editablePet => _editablePet;

  void _checkForPetOwnership() {
    _editablePet = petProvider.isMyPet(pet.petID) ?? false;
    notifyListeners();
  }

  void toggleEditMode() {
    _editMode = !_editMode;
    notifyListeners();
  }

  void updatePetData(Pet Function(Pet) updatePet) {
    pet = updatePet(pet);
    notifyListeners();
  }

  Future submit(BuildContext context) async {
    if (formKey?.currentState!.validate() ?? false) {
      toggleEditMode();
      print('form is valid');
      formKey?.currentState!.save();
      print('form is saved');
      await petProvider.updatePet(pet: pet);
      Navigator.pop(context);
    }
  }

  // /// returns a none null form key (must me set prior to use)
  // GlobalKey<FormState> get formKey => _formKey!;

  // /// if formKey is null, set to the given key
  // set formKey(GlobalKey<FormState> formKey) {
  //   _formKey ??= formKey;
  // }
}
