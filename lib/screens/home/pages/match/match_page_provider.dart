import 'package:flutter/material.dart';
import '../../../../provider/match_provider.dart';

import '../../../../models/match.dart' as Model;

class MatchPageProvider with ChangeNotifier {
  // Dependencies
  MatchProvider matchProvider;

  // cache
  List<Model.Match>? _matches;

  MatchPageProvider({
    required this.matchProvider,
  }) {
    matchProvider.addListener(clearCache);
  }

  @override
  void dispose() {
    matchProvider.removeListener(clearCache);
    super.dispose();
  }

  List<Model.Match>? get matches {
    _matches ??= matchProvider.matches
      // TODO more comprehensive sort and filter
      ?..sort(
        (a, b) =>
            (b.matchDate?.millisecondsSinceEpoch ?? 0) -
            (a.matchDate?.millisecondsSinceEpoch ?? 0),
      );
    return _matches;
  }

  clearCache() {
    _matches = null;
    notifyListeners();
  }
}
