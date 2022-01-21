import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/pages/pet_detail/pet_detail_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:res_builder/responsive.dart';

class PetDetailPage extends StatelessWidget {
  static const routeName = "/petDetailPage";

  @override
  Widget build(BuildContext context) {
    return Consumer<PetDetailPageProvider>(
        builder: (context, petPageProvide, _) {
      final pet = petPageProvide.pet;
      return Center(
        child: Hero(
          tag: "${PetDetailPage.routeName}-${pet.id}",
          child: Card(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    TextFormField(
                      initialValue: pet.name,
                      decoration: InputDecoration.collapsed(hintText: ""),
                    ),
                    //...
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
