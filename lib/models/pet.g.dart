// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PetCWProxy {
  Pet birthday(DateTime? birthday);

  Pet description(String? description);

  Pet gender(PetGender gender);

  Pet image(Uint8List image);

  Pet name(String name);

  Pet petID(int? petID);

  Pet race(String? race);

  Pet type(PetType type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Pet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Pet(...).copyWith(id: 12, name: "My name")
  /// ````
  Pet call({
    DateTime? birthday,
    String? description,
    PetGender? gender,
    Uint8List? image,
    String? name,
    int? petID,
    String? race,
    PetType? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPet.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPet.copyWith.fieldName(...)`
class _$PetCWProxyImpl implements _$PetCWProxy {
  final Pet _value;

  const _$PetCWProxyImpl(this._value);

  @override
  Pet birthday(DateTime? birthday) => this(birthday: birthday);

  @override
  Pet description(String? description) => this(description: description);

  @override
  Pet gender(PetGender gender) => this(gender: gender);

  @override
  Pet image(Uint8List image) => this(image: image);

  @override
  Pet name(String name) => this(name: name);

  @override
  Pet petID(int? petID) => this(petID: petID);

  @override
  Pet race(String? race) => this(race: race);

  @override
  Pet type(PetType type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Pet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Pet(...).copyWith(id: 12, name: "My name")
  /// ````
  Pet call({
    Object? birthday = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? petID = const $CopyWithPlaceholder(),
    Object? race = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return Pet(
      birthday: birthday == const $CopyWithPlaceholder()
          ? _value.birthday
          // ignore: cast_nullable_to_non_nullable
          : birthday as DateTime?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      gender: gender == const $CopyWithPlaceholder() || gender == null
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as PetGender,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as Uint8List,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      petID: petID == const $CopyWithPlaceholder()
          ? _value.petID
          // ignore: cast_nullable_to_non_nullable
          : petID as int?,
      race: race == const $CopyWithPlaceholder()
          ? _value.race
          // ignore: cast_nullable_to_non_nullable
          : race as String?,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as PetType,
    );
  }
}

extension $PetCopyWith on Pet {
  /// Returns a callable class that can be used as follows: `instanceOfPet.copyWith(...)` or like so:`instanceOfPet.copyWith.fieldName(...)`.
  _$PetCWProxy get copyWith => _$PetCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      petID: json['petID'] as int?,
      name: json['name'] as String,
      image: const ImageConverter().fromJson(json['image'] as String),
      type:
          $enumDecodeNullable(_$PetTypeEnumMap, json['type']) ?? PetType.other,
      gender: $enumDecodeNullable(_$PetGenderEnumMap, json['gender']) ??
          PetGender.other,
      race: json['race'] as String?,
      description: json['description'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'petID': instance.petID,
      'name': instance.name,
      'image': const ImageConverter().toJson(instance.image),
      'type': _$PetTypeEnumMap[instance.type],
      'gender': _$PetGenderEnumMap[instance.gender],
      'race': instance.race,
      'description': instance.description,
      'birthday': instance.birthday?.toIso8601String(),
    };

const _$PetTypeEnumMap = {
  PetType.other: 'other',
  PetType.dog: 'dog',
  PetType.cat: 'cat',
  PetType.bird: 'bird',
  PetType.fish: 'fish',
};

const _$PetGenderEnumMap = {
  PetGender.other: 'other',
  PetGender.male: 'male',
  PetGender.female: 'female',
};
