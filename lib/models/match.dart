import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable()
@CopyWith()
class Match {
  final int matchID;
  final int swiperID;
  final int swipeeID;
  final bool? request;
  final bool? answer;
  final DateTime matchDate;

  Match({
    required this.matchID,
    required this.swiperID,
    required this.swipeeID,
    this.request,
    this.answer,
    required this.matchDate,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);

  get toJson => _$MatchToJson(this);
}
