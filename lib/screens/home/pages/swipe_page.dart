import 'package:flutter/material.dart';
import 'package:hunde_zunder/screens/home/pages/swipe_page_provider.dart';
import 'package:provider/src/provider.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Dismissible(
                key: const Key('dismissible1'),
                child: context.read<SwipePageProvider>().nextSwipeCard,
                onDismissed: (direction) {
                  print("direction.index: ${direction.index}");
                },
                secondaryBackground: Icon(Icons.delete),
                background: Icon(Icons.favorite),
              ),
              Dismissible(
                key: const Key('dismissible2'),
                child: context.read<SwipePageProvider>().nextSwipeCard,
                onDismissed: (direction) {
                  print("direction.index: ${direction.index}");
                },
                secondaryBackground: Icon(Icons.delete),
                background: Icon(Icons.favorite),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
