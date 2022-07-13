import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hunde_zunder/constants/frontend/ui_theme.dart';
import 'package:hunde_zunder/models/chat_message.dart';
import 'package:intl/intl.dart';

class MessageCard extends StatelessWidget {
  final ChatMessage message;
  final ChatMessageSender sender;

  const MessageCard({
    Key? key,
    required this.message,
    required this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 1,
      color: sender == ChatMessageSender.me
          ? UiTheme.primaryColor
          : UiTheme.tertiaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: sender == ChatMessageSender.me
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              softWrap: true,
              textAlign: sender == ChatMessageSender.other
                  ? TextAlign.left
                  : TextAlign.right,
            ),
            Text(
              DateFormat("M/d HH:mm").format(message.timestamp),
              style: theme.textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
