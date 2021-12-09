import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/screens/home/pages/pet_provider.dart';
import 'package:provider/src/provider.dart';

class PetPage extends StatelessWidget {
  const PetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'PetPage',
            style: Theme.of(context).textTheme.headline3,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView(
                children: [
                  ...context.read<PetProvider>().pets.map(
                        (pet) => ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: pet.imageUrl,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          title: Text(pet.name),
                        ),
                      ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add Pet'),
            ),
            onPressed: () {
              // context.read<PetProvider>().addPet();
            },
          ),
        ],
      ),
    );
  }
}
