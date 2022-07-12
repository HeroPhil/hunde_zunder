import 'package:flutter/foundation.dart';
import 'package:hunde_zunder/models/chat_message.dart';

class ChatPageProvider with ChangeNotifier {
  List<ChatMessage>? _messages;

  ChatPageProvider() {
    init();
  }

  void init() {}

  List<ChatMessage>? get messages {
    _messages ??= [
      ChatMessage(
        matchID: 1,
        senderID: 1,
        message: "Hi",
        timestamp: DateTime.now(),
      ),
      ChatMessage(
          matchID: 1,
          senderID: 2,
          message: "Hi you too",
          timestamp: DateTime.now()),
    ]; // TODO backend

    return _messages;
  }
}
