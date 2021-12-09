import 'package:flutter/material.dart';
import 'package:hunde_zunder/screens/home/pages/swipe_page_provider.dart';
import 'package:hunde_zunder/screens/home/pages/widget/swipe_card.dart';
import 'package:provider/src/provider.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ...context.watch<SwipePageProvider>().loadedPets.reversed.map(
                      (pet) => Dismissible(
                        key: Key('swipe-card-${pet.id}'),
                        child: SwipeCard(
                          pet: pet,
                        ),
                        onDismissed: (DismissDirection direction) {
                          context.read<SwipePageProvider>().swipeCard(
                              SwipeResult.values[direction.index - 2]);
                        },
                        secondaryBackground: Icon(Icons.delete),
                        background: Icon(Icons.favorite),
                      ),
                    ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
