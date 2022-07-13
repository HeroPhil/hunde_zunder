import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/constants/backend/api_endpoints.dart';
import 'package:hunde_zunder/services/backend_service.dart';
import 'package:mutex/mutex.dart';
import '../../../../models/pet.dart';
import '../../../../models/match.dart' as Model;
import '../../../../provider/pet_provider.dart';

enum SwipeResult {
  hate,
  love,
}

class SwipePageProvider with ChangeNotifier {
  static final _mutex = Mutex();

  // dependencies
  final PetProvider petProvider;
  late final List<void Function()> petProviderListener;
  final BackendService backendService;

  // cache
  List<Model.Match>? _matches;
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

  List<Model.Match>? get matches {
    if (!_mutex.isLocked && _matches == null) {
      if (petProvider.currentPet == null) {
        print("ERR: no pet selected");
        return [];
      }

      _mutex.protect(
        () {
          return backendService
              .callBackend<Model.Match>(
            requestType: RequestType.GET,
            endpoint: ApiEndpoints.newMatchForId(
              petProvider.currentPet!.petID.toString(),
            ),
            jsonParser: (json) => Model.Match.fromJson(json),
          )
              .then((matches) {
            (_matches ??= []).addAll(matches);
          }).then((_) => notifyListeners());
        },
      );
    }

    return _matches;
  }

  Pet? get candidate {
    if (_candidate == null) {
      if (matches?.isEmpty ?? true) {
        return null;
      }

      final foreignPetID =
          currentMatch!.swipeeID == petProvider.currentPet?.petID
              ? matches!.first.swiperID
              : matches!.first.swipeeID;
      petProvider
          .getPetByID(petID: foreignPetID)
          .then((pet) => _candidate = pet)
          .then((value) => notifyListeners());
    }

    return _candidate;
  }

  Model.Match? get currentMatch => matches?.first;

  Future swipeCard(SwipeResult result) async {
    final boolResult = result == SwipeResult.love;

    final isSwipee = currentMatch!.swipeeID == petProvider.currentPet!.petID;

    Model.Match updatedMatch = currentMatch!.copyWith(
      answer: isSwipee ? boolResult : currentMatch!.answer,
      request: isSwipee ? currentMatch!.request : boolResult,
      matchDate: DateTime.now(),
    );

    // ? wait for backend to respond before clearing cache
    // ! yes because otherwise race condition might return the same match again
    // ? maybe if their are more cached?
    // ! doen't matter just await the shit
    // TODO maybe their needs to be a page wide loading control?
    await backendService.callBackend(
      requestType: RequestType.PUT,
      endpoint: ApiEndpoints.matchById(
        matches!.first.matchID.toString(),
      ),
      body: updatedMatch.toJson,
    );

    // either Way, remove from stack
    _matches!.removeAt(0);
    // and reset candidate
    _candidate = null;

    // if all candidates are gone, get new ones
    print("matches remaining: ${matches?.length}");
    if (_matches!.isEmpty) {
      print("new matches are needed");
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
