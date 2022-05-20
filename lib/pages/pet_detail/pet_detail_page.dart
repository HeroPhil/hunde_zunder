import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/constants/frontend/ui_assets.dart';
import 'package:hunde_zunder/pages/pet_detail/pet_detail_page_provider.dart';
import 'package:image_picker/image_picker.dart';
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
                        FormField<Uint8List>(
                          initialValue: petPageProvider.pet.image,
                          builder: (formFieldState) => GestureDetector(
                            onTap: petPageProvider.editMode
                                ? () async => (await ImagePicker()
                                        .pickImage(source: ImageSource.gallery))
                                    ?.readAsBytes()
                                    .then(
                                      (value) =>
                                          formFieldState.didChange(value),
                                    )
                                : null,
                            child: Column(
                              children: [
                                Image.memory(formFieldState.value ??
                                    UiAssets.defaultDogImage),
                                if (formFieldState.hasError)
                                  Text(
                                    formFieldState.errorText ?? "no error",
                                    style: TextStyle(color: Colors.red),
                                  )
                              ],
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value == UiAssets.defaultDogImage) {
                              return "Please upload an image";
                            }
                          },
                          onSaved: (value) => petPageProvider.updatePetData(
                            (p0) => p0.copyWith.image(value!),
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
                          validator: (value) => (null == value ||
                                  value.isEmpty ||
                                  value == "New Pet")
                              ? "Please enter a name"
                              : null,
                          decoration: inputDecoration.copyWith(
                            icon: Icon(Icons.confirmation_num),
                            label: Text("Pet Name"),
                          ),
                          onSaved: (value) => petPageProvider.updatePetData(
                            (p0) => p0.copyWith.name(value!),
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
                                onSaved: (value) =>
                                    petPageProvider.updatePetData(
                                  (p0) => p0.copyWith.type(value!),
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
                                onSaved: (value) =>
                                    petPageProvider.updatePetData(
                                  (p0) => p0.copyWith.gender(value!),
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
                          onSaved: (value) => petPageProvider.updatePetData(
                            (p0) => p0.copyWith.race(value),
                          ),
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
                          onSaved: (value) => petPageProvider.updatePetData(
                            (p0) => p0.copyWith.description(value!),
                          ),
                        ),
                        if (pet.birthday != null)
                          TextFormField(
                            initialValue:
                                "${pet.birthday!.difference(DateTime.now()).inDays / 30}",
                            enabled: petPageProvider.editMode,
                            // TODO add validation
                            validator: (value) {
                              // month value should be a non null positiv integer which is not bigger than 200
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.parse(value) <= 0 ||
                                  int.parse(value) > 200) {
                                return "Please enter a valid month value";
                              }
                            },
                            decoration: inputDecoration.copyWith(
                              icon: Icon(Icons.cake),
                              label: Text("Pet Birthday"),
                            ),
                            onSaved: (value) => petPageProvider.updatePetData(
                              (p0) => p0.copyWith.birthday(
                                DateTime.now().subtract(
                                  Duration(
                                    days: int.parse(value!),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (petPageProvider.editMode)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () =>
                                    petPageProvider.submit(context),
                                icon: Icon(Icons.save_outlined),
                                label: Text("Save"),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      "Are you sure you want to discard your changes?",
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text("Continue"),
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                      ),
                                      TextButton(
                                        child: Text("Exit"),
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                      ),
                                    ],
                                  ),
                                ).then(
                                  (discard) {
                                    if (discard) Navigator.pop(context);
                                  },
                                ),
                                icon: Icon(Icons.cancel_outlined),
                                label: Text("Discard"),
                              ),
                            ],
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
