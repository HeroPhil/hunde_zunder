import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/constants/backend/api_endpoints.dart';
import '../models/pet.dart';
import 'mock_provider.dart';
import '../services/backend_service.dart';

class PetProvider with ChangeNotifier {
  //dependencies
  final MockProvider mockProvider;
  final BackendService backendService;

  // data
  Set<int>? _myPetIDs;
  Set<Pet>? _pets;

  // state
  Pet? _currentPet;

  PetProvider({
    required this.mockProvider,
    required this.backendService,
  });

  void clearCache() {
    _myPetIDs = null;
    _pets = null;
  }

  Future<Pet?> getPetByID({
    required int petID,
  }) async {
    Pet? result;
    try {
      result = _pets?.firstWhere((pet) => pet.petID == petID);
    } on StateError catch (_) {}

    return result ??
        await backendService
            .callBackend(
              requestType: RequestType.GET,
              endpoint: ApiEndpoints.petById("$petID"),
              jsonParser: (json) => Pet.fromJson(json),
            )
            .then((resultList) => resultList.first)
            .then((pet) {
          (_pets ??= {}).add(pet);
          return pet;
        }).catchError(
          (error, stackTrace) => print(
              "some error occurred trying to get Pet $petID from the backend:\n$error\n---$stackTrace\n==="),
        );
  }

  List<Pet>? get myPets {
    if (_myPetIDs == null) {
      backendService
          .callBackend(
            requestType: RequestType.GET,
            endpoint: ApiEndpoints.pets,
            jsonParser: (json) => Pet.fromJson(json),
          )
          .then((pets) {
            (_pets ??= {}).addAll(pets);
            (_myPetIDs ??= {})
                .addAll(pets.map<int>((Pet pet) => pet.petID).toList());
            if (pets.isNotEmpty) currentPet ??= pets.first;
          })
          .then((_) => notifyListeners())
          .catchError(
            (error, stackTrace) => print(
                "some error occurred trying to get myPets from the backend:\n$error\n---$stackTrace\n==="),
          );
    }

    // _myPets ??= {
    //   Pet(
    //     name: 'Puppy',
    //     image: mockProvider.dogImages[0],
    //   ),
    //   Pet(
    //     name: 'Ralf',
    //     image: mockProvider.dogImages[1],
    //   ),
    //   Pet(
    //     name: 'Rudloff',
    //     image: mockProvider.dogImages[2],
    //   ),
    // };

    return _pets
        ?.where((pet) => _myPetIDs?.contains(pet.petID) ?? false)
        .toList();
  }

  Pet? get currentPet => _currentPet;

  set currentPet(Pet? currentPet) {
    _currentPet = currentPet;
    notifyListeners();
  }

  Future updatePet({
    required Pet pet,
  }) async {
    final isUpdate = _pets?.remove(pet) ?? false;

    // add to cache
    _pets?.add(pet);

    // update Backend
    await backendService.callBackend(
      requestType: isUpdate ? RequestType.PUT : RequestType.POST,
      endpoint: isUpdate
          ? ApiEndpoints.petById(pet.petID.toString())
          : ApiEndpoints.pets,
      body: pet.toJson,
    );

    // clear cache
    if (!isUpdate) clearCache();

    notifyListeners();
  }

  Pet get nextForeignPet {
    return Pet(
      name: "Pet-${Random().nextInt(100)}",
      image: mockProvider
          .dogImages[Random().nextInt(mockProvider.dogImages.length)],
    );
  }

  bool? isMyPet(int petId) {
    return _myPetIDs?.contains(petId);
  }
}
