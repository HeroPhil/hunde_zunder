// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatMessageCWProxy {
  ChatMessage matchID(int matchID);

  ChatMessage message(String message);

  ChatMessage senderID(int senderID);

  ChatMessage timestamp(DateTime timestamp);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChatMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChatMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  ChatMessage call({
    int? matchID,
    String? message,
    int? senderID,
    DateTime? timestamp,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChatMessage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChatMessage.copyWith.fieldName(...)`
class _$ChatMessageCWProxyImpl implements _$ChatMessageCWProxy {
  final ChatMessage _value;

  const _$ChatMessageCWProxyImpl(this._value);

  @override
  ChatMessage matchID(int matchID) => this(matchID: matchID);

  @override
  ChatMessage message(String message) => this(message: message);

  @override
  ChatMessage senderID(int senderID) => this(senderID: senderID);

  @override
  ChatMessage timestamp(DateTime timestamp) => this(timestamp: timestamp);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChatMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChatMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  ChatMessage call({
    Object? matchID = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? senderID = const $CopyWithPlaceholder(),
    Object? timestamp = const $CopyWithPlaceholder(),
  }) {
    return ChatMessage(
      matchID: matchID == const $CopyWithPlaceholder() || matchID == null
          ? _value.matchID
          // ignore: cast_nullable_to_non_nullable
          : matchID as int,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      senderID: senderID == const $CopyWithPlaceholder() || senderID == null
          ? _value.senderID
          // ignore: cast_nullable_to_non_nullable
          : senderID as int,
      timestamp: timestamp == const $CopyWithPlaceholder() || timestamp == null
          ? _value.timestamp
          // ignore: cast_nullable_to_non_nullable
          : timestamp as DateTime,
    );
  }
}

extension $ChatMessageCopyWith on ChatMessage {
  /// Returns a callable class that can be used as follows: `instanceOfChatMessage.copyWith(...)` or like so:`instanceOfChatMessage.copyWith.fieldName(...)`.
  _$ChatMessageCWProxy get copyWith => _$ChatMessageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      matchID: json['matchID'] as int,
      senderID: json['senderID'] as int,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'matchID': instance.matchID,
      'senderID': instance.senderID,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };
