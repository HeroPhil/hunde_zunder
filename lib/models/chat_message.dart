import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
@CopyWith()
class ChatMessage {
  final int matchID;
  final int senderID; // ? pet or user
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.matchID,
    required this.senderID,
    required this.message,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  get toJson => _$ChatMessageToJson(this);
}
