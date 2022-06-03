import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'app_router.dart';
import 'constants/frontend/ui_theme.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/loading/loading_screen.dart';
import 'package:provider/src/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetConnect',
      theme: UiTheme.lightTheme,
      darkTheme: UiTheme.darkTheme,
      home: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacementNamed(
              context,
              context.read<User?>() != null
                  ? HomeScreen.routeName
                  : AuthScreen.routeName,
            );
          });
          return LoadingScreen();
        },
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
