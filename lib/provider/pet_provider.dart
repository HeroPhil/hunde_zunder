import 'dart:math';

import 'package:flutter/material.dart';
import '../models/pet.dart';
import 'mock_provider.dart';
import '../services/backend_service.dart';

class PetProvider with ChangeNotifier {
  //dependencies
  final MockProvider mockProvider;
  final BackendService backendService;

  // data
  Set<Pet>? _myPets;

  PetProvider({
    required this.mockProvider,
    required this.backendService,
  });

  List<Pet>? get myPets {
    // if (_myPets == null) {
    //   (backendService.callBackend(
    //     requestType: RequestType.GET,
    //     endpoint: "mypets",
    //   ) as Future<List<Map<String, dynamic>>>)
    //       .then(
    //         (jsonList) => jsonList.map((json) => Pet.fromJson(json)).toList(),
    //       )
    //       .then(
    //         (pets) => _myPets = pets.toSet(),
    //       )
    //       .then((_) => notifyListeners());
    // }

    _myPets ??= {
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
    };
    return _myPets!.toList();
  }

  Future updatePet({
    required Pet pet,
  }) async {
    final isUpdate = _myPets?.remove(pet) ?? false;
    // add to cache
    _myPets?.add(pet);
    // update Backend
    await backendService.callBackend(
      requestType: isUpdate ? RequestType.PUT : RequestType.POST,
      endpoint: 'mypets${isUpdate ? '/${pet.petID}' : ""}',
      body: pet.toJson,
    );
    // clear cache
    if (!isUpdate) _myPets = null;
    notifyListeners();
  }

  Pet get nextForeignPet {
    return Pet(
      name: "Pet-${Random().nextInt(100)}",
      image: mockProvider
          .dogImages[Random().nextInt(mockProvider.dogImages.length)],
    );
  }
}
