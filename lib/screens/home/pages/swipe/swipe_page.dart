import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hunde_zunder/screens/home/pages/swipe/widgets/pet_selector.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:res_builder/responsive.dart';
import '../../../../constants/frontend/ui_assets.dart';
import '../../../../models/pet.dart';
import '../../../../models/match.dart';
import '../../../../pages/pet_detail/pet_detail_page.dart';

import 'package:provider/src/provider.dart';

import '../../../../provider/pet_provider.dart';
import 'swipe_page_provider.dart';
import 'widgets/swipe_card.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PetSelector(),
          Selector<SwipePageProvider, Pet?>(
              selector: (context, provider) => provider.candidate,
              builder: (context, pet, _) {
                //! on error / loading
                if (pet == null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Builder(
                        builder: (context) {
                          late final String lottiePath;
                          late final String text;
                          if (context.read<SwipePageProvider>().matches ==
                              null) {
                            lottiePath =
                                "${UiAssets.baseLottieImg}/loading_matches.json";
                            text =
                                "Looking for someone to meet with ${context.watch<PetProvider>().currentPet?.name ?? 'your Pet'}.";
                          } else {
                            lottiePath =
                                "${UiAssets.baseLottieImg}/loading_matches.json";
                            text =
                                "Looking for someone to meet with ${context.watch<PetProvider>().currentPet?.name ?? 'your Pet'}.";
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LottieBuilder.asset(
                                lottiePath,
                              ),
                              Text(
                                text,
                                style: theme.textTheme.headline5,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }
                //! real content
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
              }),
        ],
      ),
    );
  }
}
