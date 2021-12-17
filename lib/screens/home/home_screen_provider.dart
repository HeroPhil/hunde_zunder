import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  late final PageController pageController;

  HomeScreenProvider() {
    init();
  }

  void init() {
    pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void setPage(int page) async {
    await pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}
