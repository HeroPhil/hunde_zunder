import 'dart:math';

import 'package:flutter/material.dart';

class SwipeCard extends StatelessWidget {
  const SwipeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 100,
        height: 200,
        color: Colors.accents.firstWhere(
          (_) => Random().nextDouble() < 0.2,
          orElse: () => Colors.redAccent,
        ),
      ),
    );
  }
}
