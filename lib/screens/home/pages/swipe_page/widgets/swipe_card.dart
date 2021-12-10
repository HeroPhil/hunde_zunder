import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';

class SwipeCard extends StatelessWidget {
  final Pet pet;

  const SwipeCard({
    Key? key,
    required this.pet,
  }) : super(key: key);

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
        child: Stack(
          children: [
            Text(pet.name),
            Positioned.fill(
              child:
                  //   CachedNetworkImage(
                  //     imageUrl: pet.image,
                  //     fit: BoxFit.cover,
                  //   ),
                  Image.memory(pet.image),
            ),
          ],
        ),
      ),
    );
  }
}
