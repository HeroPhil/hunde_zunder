import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../models/match.dart' as Model;
import 'pet_provider.dart';

import 'mock_provider.dart';

class MatchProvider with ChangeNotifier {
  //dependencies
  final PetProvider petProvider;

  // data
  List<Model.Match>? _matches;

  MatchProvider({
    required this.petProvider,
  });

  List<Model.Match>? get matches {
    // DB Mock
    // _matches ??= [
    //   Model.Match(
    //     myPet: petProvider.myPets!.first,
    //     foreignPet: petProvider.nextForeignPet,
    //     matchDate: DateTime.now(),
    //   ),
    //   Model.Match(
    //     myPet: petProvider.myPets![1],
    //     foreignPet: petProvider.nextForeignPet,
    //     matchDate: DateTime.now().subtract(Duration(days: 1)),
    //   ),
    //   Model.Match(
    //     myPet: petProvider.myPets!.first,
    //     foreignPet: petProvider.nextForeignPet,
    //     matchDate: DateTime.now().subtract(Duration(days: 3)),
    //   ),
    //   Model.Match(
    //     myPet: petProvider.myPets![2],
    //     foreignPet: petProvider.nextForeignPet,
    //     matchDate: DateTime.now().subtract(Duration(days: 2)),
    //   ),
    //   Model.Match(
    //     myPet: petProvider.myPets![2],
    //     foreignPet: petProvider.nextForeignPet,
    //     matchDate: DateTime.now()..subtract(Duration(minutes: 40)),
    //   ),
    // ]..sort((a, b) => b.matchDate.compareTo(a.matchDate));

    // return _matches;
    return [];
  }
}
