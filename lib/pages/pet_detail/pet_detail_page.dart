import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/models/pet.dart';
import 'package:res_builder/responsive.dart';

class PetDetailPage extends StatelessWidget {
  static const routeName = "/petDetailPage";
  Pet pet;

  PetDetailPage({
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "${PetDetailPage.routeName}-${pet.id}",
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      pet.image,
                      width: MediaQuery.of(context).size.width /
                          Responsive.value(
                            context: context,
                            onMobile: 1.3,
                            onTablet: 2,
                            onDesktop: 3,
                          ),
                    ),
                  ),
                  Text(pet.name),
                  //...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
