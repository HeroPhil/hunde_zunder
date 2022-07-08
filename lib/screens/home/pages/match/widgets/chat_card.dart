import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:hunde_zunder/models/match.dart' as Model;
import 'package:hunde_zunder/provider/pet_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../models/pet.dart';

class ChatCard extends StatelessWidget {
  final Model.Match match;

  const ChatCard({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<PetProvider>(builder: (context, petProvider, _) {
        final isSwipeeMyPet = petProvider.isMyPet(match.swipeeID);

        if (isSwipeeMyPet == null) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        }

        final myPet = petProvider.getPetByID(
          petID: isSwipeeMyPet ? match.swipeeID : match.swiperID,
        );
        final otherPet = petProvider.getPetByID(
          petID: isSwipeeMyPet ? match.swiperID : match.swipeeID,
        );

        final future = Future.wait([myPet, otherPet]);

        return FutureBuilder<List<Pet?>>(
            future: future,
            builder: (context, petsSnapshot) {
              if (!petsSnapshot.hasData) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }

              final pets = petsSnapshot.data;

              return ListTile(
                leading: CircleAvatar(
                  foregroundImage: Image.memory(pets![1]!.image).image,
                ),
                title: Text(pets[1]!.name),
                subtitle: (context.read<PetProvider>().myPets?.length ?? 0) > 1
                    ? Text("with ${pets[0]!.name}")
                    : null,
                trailing: match.matchDate == null
                    ? null
                    : Text(
                        DateFormat.MMMd().format(match.matchDate!),
                      ),
              );
            });
      }),
    );
  }
}
