import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/constants/backend/api_endpoints.dart';
import 'package:hunde_zunder/services/backend_service.dart';
import '../../../../models/pet.dart';
import '../../../../models/match.dart';
import '../../../../provider/pet_provider.dart';

enum SwipeResult {
  hate,
  love,
}

class SwipePageProvider with ChangeNotifier {
  // dependencies
  final PetProvider petProvider;
  late final List<void Function()> petProviderListener;
  final BackendService backendService;

  // cache
  List<Match>? _matches;
  Pet? _candidate;

  SwipePageProvider({
    required this.petProvider,
    required this.backendService,
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

  List<Match>? get matches {
    if (_matches == null) {
      if (petProvider.currentPet == null) {
        print("ERR: no pet selected");
        return [];
      }

      backendService
          .callBackend<Match>(
        requestType: RequestType.GET,
        endpoint: ApiEndpoints.newMatchForId(
          petProvider.currentPet!.petID.toString(),
        ),
        jsonParser: (json) => Match.fromJson(json),
      )
          .then((matches) {
        (_matches ??= []).addAll(matches);
      }).then((_) => notifyListeners());
    }

    return _matches;
  }

  Pet? get candidate {
    if (_candidate == null) {
      if (matches?.isEmpty ?? true) {
        return null;
      }

      final foreignPetID =
          matches!.first.swipeeID == petProvider.currentPet?.petID
              ? matches!.first.swiperID
              : matches!.first.swipeeID;
      petProvider
          .getPetByID(petID: foreignPetID)
          .then((pet) => _candidate = pet)
          .then((value) => notifyListeners());
    }

    return _candidate;
  }

  void swipeCard(SwipeResult result) async {
    if (result == SwipeResult.love) {
      // make love
      print("making love");
    } else {
      // kick in ass
      print("kicking in ass");
    }

    // ? wait for backend to respond before clearing cache
    // ! yes because otherwise race condition might return the same match again
    // ? maybe if their are more cached?
    // ! doen't matter just await the shit
    // TODO maybe their needs to be a page wide loading control?
    await backendService.callBackend(
      requestType: RequestType.PUT,
      endpoint: ApiEndpoints.matchById(matches!.first.matchID.toString()),
    );

    // either Way, remove from stack
    _matches!.removeAt(0);
    // and reset candidate
    _candidate = null;

    // if all candidates are gone, get new ones
    if (_matches!.isEmpty) {
      _matches = null;
    }

    notifyListeners();
  }

  void clearCache() {
    _matches = null;
    _candidate = null;
    notifyListeners();
  }
}
