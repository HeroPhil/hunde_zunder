import 'package:flutter/material.dart';
import 'package:hunde_zunder/screens/home/pages/chat/chat_page.dart';
import 'package:hunde_zunder/screens/home/pages/chat/chat_page_provider.dart';
import 'package:hunde_zunder/screens/home/pages/match/widgets/match_card.dart';
import '../../../../provider/pet_provider.dart';
import 'match_page_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PageView.builder(
        controller: context.read<MatchPageProvider>().pageController,
        itemCount: 2,
        itemBuilder: (context, index) {
          switch (index) {
            case 1:
              return ChatPage();
            default:
              return Column(
                children: [
                  Text(
                    'My Matches',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Consumer<MatchPageProvider>(
                    builder: (context, matchPageProvider, _) {
                      final matches = matchPageProvider.matches;
                      if (matches == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (matches.isEmpty) {
                        const Center(
                          child: Text('No matches found'), // TODO add lottie
                        );
                      }

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListView(
                            children: [
                              ...matchPageProvider.matches!.map(
                                (match) => GestureDetector(
                                  onTap: () {
                                    context.read<ChatPageProvider>().init(
                                          match: match,
                                          popBehavior: () =>
                                              matchPageProvider.page = 0,
                                        );
                                    matchPageProvider.page = 1;
                                  },
                                  child: MatchCard(
                                    match: match,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
