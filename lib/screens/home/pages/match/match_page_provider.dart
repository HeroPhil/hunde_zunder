import 'package:flutter/material.dart';
import 'package:hunde_zunder/provider/match_provider.dart';

import 'package:hunde_zunder/models/match.dart' as Model;

class MatchPageProvider with ChangeNotifier {
  // Dependencies
  MatchProvider matchProvider;

  MatchPageProvider({
    required this.matchProvider,
  });

  List<Model.Match>? get matches {
    return matchProvider.matches;
  }
}
