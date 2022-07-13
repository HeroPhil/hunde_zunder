import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../chat_page_provider.dart';

class MessageFieldCard extends StatelessWidget {
  const MessageFieldCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatPageProvider>(
      builder: (context, chatPageProvider, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                    onSubmitted: (message) {
                      // chatPageProvider.sendMessage(message);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // chatPageProvider.sendMessage(
                    //   chatPageProvider.messageController.text,
                    // );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
