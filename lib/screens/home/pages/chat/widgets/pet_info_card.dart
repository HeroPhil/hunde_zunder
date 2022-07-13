import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hunde_zunder/pages/pet_detail/pet_detail_page.dart';
import 'package:hunde_zunder/screens/home/pages/match/match_page_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../models/pet.dart';
import '../chat_page_provider.dart';

class PetInfoCard extends StatelessWidget {
  final Pet pet;

  const PetInfoCard({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(
          PetDetailPage.routeName,
          arguments: {
            'pet': pet,
          },
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (context.read<ChatPageProvider>().popBehavior != null)
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new_sharp),
                onPressed: () {
                  context.read<ChatPageProvider>().popBehavior!();
                },
              ),
            Hero(
              tag: "${PetDetailPage.routeName}-${pet.petID}",
              child: CircleAvatar(
                foregroundImage: Image.memory(pet.image).image,
              ),
            ),
          ],
        ),
        title: Text(pet.name),
      ),
    );
  }
}
