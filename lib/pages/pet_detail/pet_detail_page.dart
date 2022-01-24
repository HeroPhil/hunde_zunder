import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/pages/pet_detail/pet_detail_page_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:res_builder/responsive.dart';
import 'package:hunde_zunder/models/pet.dart';

class PetDetailPage extends StatelessWidget {
  static const routeName = "/petDetailPage";

  PetDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PetDetailPageProvider>(
        builder: (context, petPageProvider, _) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        petPageProvider.init();
      });
      final pet = petPageProvider.pet;
      final defaultInputDecoration = InputDecoration();
      final inputDecoration = petPageProvider.editMode
          // edit decoration
          ? defaultInputDecoration.copyWith()
          // read only decoration
          : defaultInputDecoration.copyWith(
              hintText: "",
              enabled: false,
              border: InputBorder.none,
            );

      return Center(
        child: Hero(
          tag: "${PetDetailPage.routeName}-${pet.id}",
          child: Card(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width /
                      Responsive.value(
                        context: context,
                        onMobile: 1.3,
                        onTablet: 2,
                        onDesktop: 3,
                      ),
                  child: Form(
                    onWillPop: () async => !petPageProvider.editMode,
                    key: petPageProvider.formKey,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            pet.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (!petPageProvider.editMode)
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: petPageProvider.toggleEditMode,
                          ),
                        TextFormField(
                          initialValue: pet.name,
                          // TODO add validation
                          validator: (value) => null,
                          decoration: inputDecoration.copyWith(
                            icon: Icon(Icons.confirmation_num),
                            label: Text("Pet Name"),
                          ),
                          enabled: petPageProvider.editMode,
                        ),
                        petPageProvider.editMode
                            ? DropdownButtonFormField<PetType>(
                                value: pet.type,
                                items: PetType.values
                                    .map((petType) => DropdownMenuItem<PetType>(
                                          value: petType,
                                          child: Text(petType.name),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                                decoration: inputDecoration.copyWith(
                                  icon: Icon(Icons.pets),
                                  label: Text("Pet Type"),
                                ),
                              )
                            : TextFormField(
                                initialValue: pet.type.name,
                                // TODO add validation
                                validator: (value) => null,
                                decoration: inputDecoration.copyWith(
                                  icon: Icon(Icons.pets),
                                  label: Text("Pet Type"),
                                ),
                                enabled: false,
                              ),
                        petPageProvider.editMode
                            ? DropdownButtonFormField<PetGender>(
                                value: pet.gender,
                                items: PetGender.values
                                    .map((petGender) =>
                                        DropdownMenuItem<PetGender>(
                                          value: petGender,
                                          child: Text(petGender.name),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                                decoration: inputDecoration.copyWith(
                                  icon: Icon(Icons.transgender),
                                  label: Text("Pet Gender"),
                                ),
                              )
                            : TextFormField(
                                initialValue: pet.gender.name,
                                decoration: inputDecoration.copyWith(
                                  icon: Icon(Icons.transgender),
                                  label: Text("Pet Gender"),
                                ),
                                enabled: false,
                              ),
                        TextFormField(
                          initialValue: pet.race,
                          // TODO add validation
                          validator: (value) => null,
                          decoration: inputDecoration.copyWith(
                            icon: Icon(Icons.category),
                            label: Text("Pet Race"),
                          ),
                          enabled: petPageProvider.editMode,
                        ),
                        TextFormField(
                          initialValue: pet.description,
                          // TODO add validation
                          validator: (value) => null,
                          decoration: inputDecoration.copyWith(
                            icon: Icon(Icons.description),
                            label: Text("Description"),
                          ),
                          enabled: petPageProvider.editMode,
                        ),
                        if (pet.birthday != null)
                          TextFormField(
                            initialValue:
                                "${pet.birthday!.difference(DateTime.now()).inDays / 30}",
                            enabled: petPageProvider.editMode,
                            // TODO add validation
                            validator: (value) => null,
                            decoration: inputDecoration.copyWith(
                              icon: Icon(Icons.cake),
                              label: Text("Pet Birthday"),
                            ),
                          ),
                        if (petPageProvider.editMode)
                          OutlinedButton.icon(
                            onPressed: petPageProvider.submit,
                            icon: Icon(Icons.save_outlined),
                            label: Text("Save"),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
