import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';
import 'package:provider/provider.dart';

class PetSelector extends StatelessWidget {
  const PetSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<PetProvider>(
      builder: (context, petProvider, _) {
        final pets = petProvider.myPets;

        if (pets == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (pets.isEmpty || pets.length == 1) {
          return Container();
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Which pet is looking for new friends?",
                style: theme.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButton<Pet>(
                value: petProvider.currentPet,
                borderRadius: BorderRadius.circular(8),
                underline: Container(),
                items: pets
                    .map(
                      (pet) => DropdownMenuItem<Pet>(
                        value: pet,
                        child: buildPetTile(pet),
                      ),
                    )
                    .toList(),
                onChanged: (pet) => petProvider.currentPet = pet,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPetTile(Pet pet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          foregroundImage: Image.memory(pet.image).image,
        ),
        Text(pet.name),
      ],
    );
  }
}
