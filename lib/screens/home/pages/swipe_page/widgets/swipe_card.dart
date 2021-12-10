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
    final frameSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Card(
      child: Container(
        width: frameSize.width * 0.8,
        height: frameSize.height * 0.6,
        color: Colors.accents.firstWhere(
          (_) => Random().nextDouble() < 0.2,
          orElse: () => Colors.redAccent,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.memory(
                pet.image,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    pet.name,
                    style: theme.textTheme.headline5!.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
