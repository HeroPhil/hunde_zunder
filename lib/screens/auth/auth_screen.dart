import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hunde_zunder/constants/frontend/ui_theme.dart';
import 'package:hunde_zunder/screens/auth/auth_screen_provider.dart';
import 'package:hunde_zunder/services/firebase_auth_service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final animatedText = AnimatedTextKit(
      key: context.read<AuthScreenProvider>().animatedTextKey,
      repeatForever: true,
      displayFullTextOnTap: true,
      animatedTexts: [
        "Welcome to PetConnect!",
        ...([
          "Find new friends for your best friend!",
          "PetConnect is a social network for pets.",
          "KarottenKameraden for the win!",
          "We love pets!",
          "Welcome to the best social network for pets!",
          "Does your pet like carrots? Contact us for a special gift!",
          "Sign up today and start connecting with your fluffy friends!",
          "Bello lonely? Sign up and start swiping on bitches on heat!",
          "Bored by tinder? Its your dogs turn!",
        ]..shuffle())
      ]
          .map(
            (text) => TypewriterAnimatedText(
              text,
              textAlign: TextAlign.center,
              textStyle: theme.textTheme.headline3!.copyWith(
                color: UiTheme.primaryColor,
              ),
              speed: Duration(milliseconds: 120),
            ),
          )
          .toList(),
    );

    return SignInScreen(
      providerConfigs: FirebaseAuthService.providerConfigurations,
      footerBuilder: (context, action) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          "By signing up you agree to our Terms of Service and Privacy Policy.",
          "By Karotten Kameraden © 2022 | All rights reserved.",
          "Christian Bettermann | Philip Herold | Michael Kaiser | Nicklas Platz",
        ]
            .map(
              (text) => Text(
                text,
                style: theme.textTheme.bodyText2!.copyWith(
                  color: UiTheme.primaryColor,
                ),
              ),
            )
            .toList(),
      ),
      headerBuilder: (context, constraints, shrinkOffset) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: animatedText,
        ),
      ),
      sideBuilder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              animatedText,
              LottieBuilder.asset(
                "assets/lotties/fancy_dog.json",
                height: constraints.maxHeight / 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
