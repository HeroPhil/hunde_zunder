import 'package:flutter/material.dart';
import 'package:res_builder/responsive.dart';
import '../../../../pages/pet_detail/pet_detail_page.dart';

import 'package:provider/src/provider.dart';

import 'swipe_page_provider.dart';
import 'widgets/swipe_card.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! Multi Pets
    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     ...context.watch<SwipePageProvider>().loadedPets.reversed.map(
    //           (pet) => Positioned.fill(
    //             child: Center(
    //               child: GestureDetector(
    //                 onDoubleTap: () => Navigator.pushNamed(
    //                   context,
    //                   PetDetailPage.routeName,
    //                   arguments: {"pet": pet},
    //                 ),
    //                 child: Dismissible(
    //                   key: Key('swipe-card-${pet.petID}'),
    //                   child: Hero(
    //                     tag: "${PetDetailPage.routeName}-${pet.petID}",
    //                     child: SwipeCard(
    //                       pet: pet,
    //                     ),
    //                   ),
    //                   onDismissed: (DismissDirection direction) {
    //                     context
    //                         .read<SwipePageProvider>()
    //                         .swipeCard(SwipeResult.values[direction.index - 2]);
    //                   },
    //                   secondaryBackground: SwipeCard.getCardBackground(
    //                     context: context,
    //                     color: Colors.red,
    //                     icon: Icons.close_rounded,
    //                   ),
    //                   background: SwipeCard.getCardBackground(
    //                     context: context,
    //                     color: Colors.blue,
    //                     icon: Icons.favorite_rounded,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //   ],
    // );

    //! only one Pet
    final pet = context.watch<SwipePageProvider>().loadedPets.reversed.first;
    return Center(
      child: GestureDetector(
        onDoubleTap: () => Navigator.pushNamed(
          context,
          PetDetailPage.routeName,
          arguments: {"pet": pet},
        ),
        child: Dismissible(
          key: Key('swipe-card-${pet.petID}'),
          child: Hero(
            tag: "${PetDetailPage.routeName}-${pet.petID}",
            child: SwipeCard(
              pet: pet,
            ),
          ),
          secondaryBackground: SwipeCard.getCardBackground(
            context: context,
            color: Colors.red,
            icon: Icons.close_rounded,
          ),
          background: SwipeCard.getCardBackground(
            context: context,
            color: Colors.blue,
            icon: Icons.favorite_rounded,
          ),
          onDismissed: (DismissDirection direction) {
            context
                .read<SwipePageProvider>()
                .swipeCard(SwipeResult.values[direction.index - 2]);
          },
          crossAxisEndOffset: -1 / 7,
          resizeDuration: Duration(milliseconds: 500),
          movementDuration: Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
