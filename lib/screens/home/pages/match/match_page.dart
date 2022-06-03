import 'package:flutter/material.dart';
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
      child: Consumer<MatchPageProvider>(
        builder: (context, matchPageProvider, _) {
          final matches = matchPageProvider.matches;
          if (matches == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Text(
                'My Matches',
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView(
                    children: [
                      // if (matches.isEmpty)
                      const Center(
                        child: Text('No matches found'),
                      ),
                      // ...matchPageProvider.matches!.map(
                      //   (match) => Card(
                      //     child: ListTile(
                      //       leading: CircleAvatar(
                      //         foregroundImage:
                      //             Image.memory(match.foreignPet.image).image,
                      //       ),
                      //       title: Text(match.foreignPet.name),
                      //       subtitle:
                      //           (context.read<PetProvider>().myPets?.length ??
                      //                       0) >
                      //                   1
                      //               ? Text("with ${match.myPet.name}")
                      //               : null,
                      //       trailing: Text(
                      //         DateFormat.MMMd().format(match.matchDate),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   child: const Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Text('Add Pet'),
              //   ),
              //   onPressed: () {
              //     // context.read<PetProvider>().addPet();
              //   },
              // ),
            ],
          );
        },
      ),
    );
  }
}
