import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/app.dart';
import 'package:hunde_zunder/provider/auth_provider.dart';
import 'package:hunde_zunder/provider/match_provider.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';
import 'package:hunde_zunder/screens/loading/loading_screen.dart';
import 'package:hunde_zunder/services/authentication_service.dart';
import 'package:hunde_zunder/services/backend_service.dart';
import 'package:hunde_zunder/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

import 'constants/frontend/ui_assets.dart';
import 'provider/mock_provider.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // register prerequisites Initializers
        FutureProvider<bool>(
          create: (_) => Future.wait(<Future>[UiAssets.init(context)])
              .then<bool>((_) => true),
          initialData: false,
        ),
        ChangeNotifierProvider<FirebaseAuthService>(
          create: (context) => FirebaseAuthService(),
        ),
        ChangeNotifierProvider<BackendService>(
          create: (context) => BackendService(
              firebaseAuthService: context.read<FirebaseAuthService>()),
        ),
        // TODO use Model to broadcast currentUser
        StreamProvider<User?>(
          create: (context) =>
              context.read<FirebaseAuthService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider<MockProvider>(
          create: (_) => MockProvider(bundle: DefaultAssetBundle.of(context)),
        ),
      ],
      builder: (context, _) {
        if (!context.watch<MockProvider>().initialized ||
                !context
                    .watch<bool>() // watch if all prerequisites are initialized

            ) {
          return MaterialApp(home: LoadingScreen());
        }

        final User? user = context.watch<User?>();

        // register Global Provider here
        return ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            firebaseAuthService: context.read<FirebaseAuthService>(),
          ),
          builder: (context, app) {
            final _mockProvider = context.read<MockProvider>();
            final _backendService = context.read<BackendService>();
            if (user != null) {
              // register Global Provider which are dependend on the currentUser here

              return MultiProvider(
                providers: [
                  ChangeNotifierProvider<PetProvider>(
                    create: (_) => PetProvider(
                      mockProvider: _mockProvider,
                      backendService: _backendService,
                    ),
                  ),
                ],
                builder: (context, _) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<MatchProvider>(
                      create: (_) => MatchProvider(
                        petProvider: context.read<PetProvider>(),
                      ),
                    ),
                  ],
                  child: app,
                ),
              );
            }
            return app!;
          },
          child: App(),
        );
      },
    );
  }
}
