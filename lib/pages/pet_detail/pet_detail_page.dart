import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import '../../constants/frontend/ui_assets.dart';
import 'pet_detail_page_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:res_builder/responsive.dart';
import '../../models/pet.dart';

class PetDetailPage extends StatelessWidget {
  static const routeName = "/petDetailPage";

  PetDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<PetDetailPageProvider>(
        builder: (context, petPageProvider, _) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   petPageProvider.init();
      // });
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

      final content = Center(
        child: Hero(
          tag: "${PetDetailPage.routeName}-${pet.petID}",
          child: Card(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: !Responsive.isMobile(context)
                      ? MediaQuery.of(context).size.width /
                          Responsive.value(
                            context: context,
                            onMobile: 1.3,
                            onTablet: 2,
                            onDesktop: 3,
                          )
                      : null,
                  child: Form(
                    onWillPop: () async => !petPageProvider.editMode,
                    key: petPageProvider.formKey,
                    child: Column(
                      children: [
                        FormField<Uint8List>(
                          initialValue: petPageProvider.pet.image,
                          builder: (formFieldState) => GestureDetector(
                            onTap: petPageProvider.editMode
                                ? () async => (await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                      maxWidth: 1024,
                                      maxHeight: 768,
                                    ))
                                        ?.readAsBytes()
                                        .then(
                                          (value) =>
                                              formFieldState.didChange(value),
                                        )
                                : null,
                            child: Column(
                              children: [
                                Image.memory(
                                  formFieldState.value ??
                                      UiAssets.defaultDogImage,
                                  // ? be smart about image size?
                                  // height: Responsive.isMobile(context)
                                  //     ? MediaQuery.of(context).size.height / 2
                                  //     : null,
                                ),
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
                        if (petPageProvider.editablePet &&
                            !petPageProvider.editMode)
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
                        // if (pet.birthday != null)
                        //   TextFormField(
                        //     initialValue:
                        //         "${pet.birthday!.difference(DateTime.now()).inDays / 30}",
                        //     enabled: petPageProvider.editMode,
                        //     validator: (value) {
                        //       // month value should be a non null positiv integer which is not bigger than 200
                        //       if (value == null ||
                        //           value.isEmpty ||
                        //           int.tryParse(value) == null ||
                        //           int.parse(value) <= 0 ||
                        //           int.parse(value) > 200) {
                        //         return "Please enter a valid month value";
                        //       }
                        //     },
                        //     decoration: inputDecoration.copyWith(
                        //       icon: Icon(Icons.cake),
                        //       label: Text("Pet Birthday"),
                        //     ),
                        //     onSaved: (value) => petPageProvider.updatePetData(
                        //       (p0) => p0.copyWith.birthday(
                        //         DateTime.now().subtract(
                        //           Duration(
                        //             days: int.parse(value!),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        FormField<DateTime?>(
                          initialValue: pet.birthday,
                          validator: (value) {
                            // pet should not be older than 50 years, but might be null
                            if (value != null &&
                                value.isBefore(
                                  DateTime.now().subtract(
                                    Duration(
                                      days: 365 * 50,
                                    ),
                                  ),
                                )) {
                              return "Pet is too old";
                            }
                          },
                          onSaved: (value) => petPageProvider.updatePetData(
                            (p0) => p0.copyWith.birthday(value),
                          ),
                          builder: (state) {
                            final controller = TextEditingController(
                              text: state.value != null
                                  ? DateFormat.yMd().format(state.value!)
                                  : "Pick a date",
                            );
                            return TextField(
                              controller: controller,
                              onTap: () => showDatePicker(
                                context: state.context,
                                initialDate: DateTime
                                    .now(), // TODO set to current value if database would not be fucked up
                                firstDate: DateTime.now().subtract(
                                  Duration(days: 365 * 100),
                                ),
                                lastDate: DateTime.now(),
                              ).then(
                                (value) => state.didChange(value),
                              ),
                              decoration: inputDecoration.copyWith(
                                icon: Icon(Icons.cake),
                                label: Text("Pet Birthday"),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (petPageProvider.editMode)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (petPageProvider.forced)
                                SignOutButton(
                                  variant: ButtonVariant.outlined,
                                ),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    petPageProvider.submit(context),
                                icon: Icon(Icons.save_outlined),
                                label: Text("Save"),
                              ),
                              if (!petPageProvider.forced)
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
      if (Responsive.isMobile(context)) {
        return Scaffold(
          appBar: !petPageProvider.editMode
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  leading: BackButton(
                    color: theme.primaryColor,
                  ),
                )
              : null,
          body: content,
          backgroundColor: Colors.transparent,
        );
      } else {
        return content;
      }
    });
  }
}
