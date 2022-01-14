import 'package:hunde_zunder/models/pet.dart';

class Match {
  Pet myPet;
  Pet foreignPet;
  DateTime matchDate;

  Match({
    required this.myPet,
    required this.foreignPet,
    required this.matchDate,
  });
}
