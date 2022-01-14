import 'package:flutter/material.dart';

import 'package:provider/src/provider.dart';

import 'swipe_page_provider.dart';
import 'widgets/swipe_card.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ...context.watch<SwipePageProvider>().loadedPets.reversed.map(
              (pet) => Positioned.fill(
                child: Center(
                  child: Dismissible(
                    key: Key('swipe-card-${pet.id}'),
                    child: SwipeCard(
                      pet: pet,
                    ),
                    onDismissed: (DismissDirection direction) {
                      context
                          .read<SwipePageProvider>()
                          .swipeCard(SwipeResult.values[direction.index - 2]);
                    },
                    secondaryBackground: Icon(Icons.delete),
                    background: Icon(Icons.favorite),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
