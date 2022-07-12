import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hunde_zunder/screens/home/pages/chat/chat_page_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/message_card.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatPageProvider>(
      builder: (context, chatPageProvider, _) {
        if (chatPageProvider.messages == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final messages = chatPageProvider.messages!;

        if (messages.isEmpty) {
          const Center(
            child: Text('No messages found'), // TODO add lottie
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool sender = messages[index].senderID == 1; // TODO
                  return Row(
                    children: [
                      if (sender) Expanded(child: Container()),
                      Expanded(
                        flex: 3,
                        child: MessageCard(
                          message: messages[index].message,
                        ),
                      ),
                      if (!sender) Expanded(child: Container()),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
