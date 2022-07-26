import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hunde_zunder/models/chat_message.dart';
import 'package:hunde_zunder/provider/mock_provider.dart';
import 'package:hunde_zunder/screens/home/pages/chat/chat_page_provider.dart';
import 'package:hunde_zunder/screens/home/pages/chat/widgets/message_field_card.dart';
import 'package:hunde_zunder/screens/home/pages/chat/widgets/pet_info_card.dart';
import 'package:provider/provider.dart';

import '../../../../models/pet.dart';
import 'widgets/message_card.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!context.read<ChatPageProvider>().initialScrolled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ChatPageProvider>().scrollToBottom();
      });
      context.read<ChatPageProvider>().initialScrolled = true;
    }

    return Consumer<ChatPageProvider>(
      builder: (context, chatPageProvider, _) {
        return Column(
          children: [
            // HEADER
            Builder(
              builder: (context) {
                return FutureBuilder<Pet?>(
                  future: chatPageProvider.otherPet,
                  builder: (context, petSnapshot) {
                    if (!petSnapshot.hasData || petSnapshot.data == null) {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }

                    final otherPet = petSnapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PetInfoCard(
                        pet: otherPet,
                      ),
                    );
                  },
                );
              },
            ),
            // BODY
            Expanded(
              child: FutureBuilder<Pet?>(
                future: chatPageProvider.myPet,
                builder: (context, petSnapshot) {
                  if (!petSnapshot.hasData || petSnapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final myPet = petSnapshot.data!;

                  final messages = chatPageProvider.messages;

                  if (messages == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (messages.isEmpty) {
                    return const Center(
                      child: Text('No messages found'), // TODO add lottie
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          controller: chatPageProvider.scrollController,
                          reverse: true,
                          children: [
                            ...messages.reversed.map(
                              (message) {
                                ChatMessageSender sender =
                                    message.senderID == myPet.petID
                                        ? ChatMessageSender.me
                                        : ChatMessageSender.other; // TODO
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    print(constraints.maxWidth);
                                    return Row(
                                      children: [
                                        if (sender == ChatMessageSender.me)
                                          Expanded(child: Container()),

                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth:
                                                constraints.maxWidth * 0.66,
                                          ),
                                          child: MessageCard(
                                            message: message,
                                            sender: sender,
                                          ),
                                        ),

                                        // ),
                                        if (sender == ChatMessageSender.other)
                                          Expanded(child: Container()),
                                      ],
                                    );
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            // FOOTER
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MessageFieldCard(),
            )
          ],
        );
      },
    );
  }
}
