import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'pet_page_provider.dart';

class PetPage extends StatelessWidget {
  const PetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<PetPageProvider>(
        builder: (context, petPageProvider, _) {
          final pets = petPageProvider.pets;
          if (pets == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
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
                      if (pets.isEmpty)
                        Center(
                          child: Text('No pets found'),
                        ),
                      ...petPageProvider.pets!.map(
                        (pet) => ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(pet.image),
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
          );
        },
      ),
    );
  }
}
