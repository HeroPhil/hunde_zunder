import 'package:flutter/material.dart';
import 'package:hunde_zunder/constants/backend/api_endpoints.dart';
import 'package:hunde_zunder/services/backend_service.dart';
import 'package:mutex/mutex.dart';
import 'package:provider/provider.dart';
import '../models/pet.dart';
import '../models/match.dart' as Model;
import 'pet_provider.dart';

import 'mock_provider.dart';

class MatchProvider with ChangeNotifier {
  static final _mutex = Mutex();

  //dependencies
  final BackendService backendService;
  final PetProvider petProvider;
  late final List<void Function()> petProviderListener;

  // data
  List<Model.Match>? _matches;

  MatchProvider({
    required this.backendService,
    required this.petProvider,
  }) {
    petProviderListener = [
      clearCache,
    ];

    petProviderListener.forEach((listener) {
      petProvider.addListener(listener);
    });
  }

  @override
  void dispose() {
    petProviderListener.forEach((listener) {
      petProvider.removeListener(listener);
    });
    super.dispose();
  }

  List<Model.Match>? get matches {
    if (!_mutex.isLocked && _matches == null) {
      _mutex.protect(() {
        final myPetIds =
            petProvider.myPets?.map((pet) => pet.petID.toString()).toList() ??
                [];

        final backendFutures = myPetIds.map(
          (petId) => backendService
              .callBackend(
            requestType: RequestType.GET,
            endpoint: ApiEndpoints.allMatchesForPet(petId),
            jsonParser: (json) => Model.Match.fromJson(json),
          )
              .then(
            (matches) {
              (_matches ??= []).addAll(matches);
            },
          ),
        );

        return Future.wait(backendFutures).then((value) => notifyListeners());
      });
    }
    return _matches;
  }

  void clearCache() {
    _matches = null;
    notifyListeners();
  }
}
