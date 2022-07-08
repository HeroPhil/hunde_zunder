import 'package:flutter/material.dart';
import 'package:hunde_zunder/screens/home/pages/match/widgets/chat_card.dart';
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
      child: Column(
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
                        (match) => ChatCard(
                          match: match,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
