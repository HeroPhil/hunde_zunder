import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res_builder/responsive.dart';
import '../../../../models/pet.dart';
import '../../../../models/match.dart';
import '../../../../pages/pet_detail/pet_detail_page.dart';

import 'package:provider/src/provider.dart';

import 'swipe_page_provider.dart';
import 'widgets/swipe_card.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Selector<SwipePageProvider, Future<Pet?>>(
          selector: (context, provider) => provider.candidate,
          builder: (context, futurePet, _) {
            return FutureBuilder<Pet?>(
                future: futurePet,
                builder: (context, petSnapshot) {
                  if (!petSnapshot.hasData) {
                    return Text("loading"); // TODO add loading
                  }

                  if (petSnapshot.data == null) {
                    return Selector<SwipePageProvider, List<Match>?>(
                        selector: (context, provider) => provider.matches,
                        builder: (context, matches, _) {
                          if (matches == null) {
                            return Text('loading'); // TODO add loading
                          }
                          return Text("no matches"); // TODO add error
                        });
                  }

                  final pet = petSnapshot.data!;

                  return GestureDetector(
                    onDoubleTap: () => Navigator.pushNamed(
                      context,
                      PetDetailPage.routeName,
                      arguments: {"pet": pet},
                    ),
                    child: Dismissible(
                      key: Key('swipe-card-${pet.petID}'),
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
                      child: Hero(
                        tag: "${PetDetailPage.routeName}-${pet.petID}",
                        child: SwipeCard(
                          pet: pet,
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
