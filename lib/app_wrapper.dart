import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hunde_zunder/pages/pet_detail/pet_detail_page.dart';
import 'package:hunde_zunder/provider/pet_provider.dart';
import 'package:hunde_zunder/screens/auth/auth_screen.dart';
import 'package:hunde_zunder/screens/crash/crash_screen.dart';
import 'package:hunde_zunder/screens/home/home_screen.dart';
import 'package:hunde_zunder/screens/loading/loading_screen.dart';
import 'package:provider/provider.dart';

class AppWrapper extends StatelessWidget {
  static const routeName = "/wrapper";
  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<PetProvider, bool?>(
      selector: (context, petProvider) => petProvider.myPets?.isEmpty,
      builder: (context, noPets, _) {
        if (noPets != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            late String navigatorTarget;
            noPets
                ? navigatorTarget = PetDetailPage.routeName
                : navigatorTarget = HomeScreen.routeName;
            Navigator.pushReplacementNamed(
              context,
              navigatorTarget,
              arguments: {'forced': true},
            );
          });
        }
        return LoadingScreen();
      },
    );
  }
}
