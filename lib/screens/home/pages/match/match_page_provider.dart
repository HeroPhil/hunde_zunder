import 'package:flutter/material.dart';
import '../../../../provider/match_provider.dart';

import '../../../../models/match.dart' as Model;

class MatchPageProvider with ChangeNotifier {
  // Dependencies
  MatchProvider matchProvider;

  // cache
  List<Model.Match>? _matches;

  // state
  late PageController _pageController;

  MatchPageProvider({
    required this.matchProvider,
  }) {
    _pageController = PageController(
      initialPage: 0,
    );
    matchProvider.addListener(clearCache);
  }

  @override
  void dispose() {
    matchProvider.removeListener(clearCache);
    super.dispose();
  }

  PageController get pageController => _pageController;

  set page(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
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
