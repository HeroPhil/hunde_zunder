// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MatchCWProxy {
  Match answer(bool? answer);

  Match matchDate(DateTime? matchDate);

  Match matchID(int matchID);

  Match request(bool? request);

  Match swipeeID(int swipeeID);

  Match swiperID(int swiperID);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Match(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Match(...).copyWith(id: 12, name: "My name")
  /// ````
  Match call({
    bool? answer,
    DateTime? matchDate,
    int? matchID,
    bool? request,
    int? swipeeID,
    int? swiperID,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMatch.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMatch.copyWith.fieldName(...)`
class _$MatchCWProxyImpl implements _$MatchCWProxy {
  final Match _value;

  const _$MatchCWProxyImpl(this._value);

  @override
  Match answer(bool? answer) => this(answer: answer);

  @override
  Match matchDate(DateTime? matchDate) => this(matchDate: matchDate);

  @override
  Match matchID(int matchID) => this(matchID: matchID);

  @override
  Match request(bool? request) => this(request: request);

  @override
  Match swipeeID(int swipeeID) => this(swipeeID: swipeeID);

  @override
  Match swiperID(int swiperID) => this(swiperID: swiperID);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Match(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Match(...).copyWith(id: 12, name: "My name")
  /// ````
  Match call({
    Object? answer = const $CopyWithPlaceholder(),
    Object? matchDate = const $CopyWithPlaceholder(),
    Object? matchID = const $CopyWithPlaceholder(),
    Object? request = const $CopyWithPlaceholder(),
    Object? swipeeID = const $CopyWithPlaceholder(),
    Object? swiperID = const $CopyWithPlaceholder(),
  }) {
    return Match(
      answer: answer == const $CopyWithPlaceholder()
          ? _value.answer
          // ignore: cast_nullable_to_non_nullable
          : answer as bool?,
      matchDate: matchDate == const $CopyWithPlaceholder()
          ? _value.matchDate
          // ignore: cast_nullable_to_non_nullable
          : matchDate as DateTime?,
      matchID: matchID == const $CopyWithPlaceholder() || matchID == null
          ? _value.matchID
          // ignore: cast_nullable_to_non_nullable
          : matchID as int,
      request: request == const $CopyWithPlaceholder()
          ? _value.request
          // ignore: cast_nullable_to_non_nullable
          : request as bool?,
      swipeeID: swipeeID == const $CopyWithPlaceholder() || swipeeID == null
          ? _value.swipeeID
          // ignore: cast_nullable_to_non_nullable
          : swipeeID as int,
      swiperID: swiperID == const $CopyWithPlaceholder() || swiperID == null
          ? _value.swiperID
          // ignore: cast_nullable_to_non_nullable
          : swiperID as int,
    );
  }
}

extension $MatchCopyWith on Match {
  /// Returns a callable class that can be used as follows: `instanceOfMatch.copyWith(...)` or like so:`instanceOfMatch.copyWith.fieldName(...)`.
  _$MatchCWProxy get copyWith => _$MatchCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      matchID: json['matchID'] as int,
      swiperID: json['swiperID'] as int,
      swipeeID: json['swipeeID'] as int,
      request: json['request'] as bool?,
      answer: json['answer'] as bool?,
      matchDate: json['matchDate'] == null
          ? null
          : DateTime.parse(json['matchDate'] as String),
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'matchID': instance.matchID,
      'swiperID': instance.swiperID,
      'swipeeID': instance.swipeeID,
      'request': instance.request,
      'answer': instance.answer,
      'matchDate': instance.matchDate?.toIso8601String(),
    };
