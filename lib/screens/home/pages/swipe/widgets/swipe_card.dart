import 'package:flutter/material.dart';
import 'package:res_builder/responsive.dart';

import '../../../../../models/pet.dart';

class SwipeCard extends StatelessWidget {
  final Pet pet;

  const SwipeCard({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final frameSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Card(
        child: Container(
          width: constraints.maxWidth * 0.8,
          height: frameSize.height * 0.6,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    pet.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      pet.name,
                      style: theme.textTheme.headline5!.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  static Positioned getCardBackground({
    required BuildContext context,
    required Color color,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return Positioned.fill(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              icon,
              size: Responsive.value<double>(
                context: context,
                onMobile: 60,
                onDesktop: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
