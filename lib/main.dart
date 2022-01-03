import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_flutter/screens/homepage/homepage.dart';
import 'package:fms_flutter/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/register/components/background.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(FirstScreen());
}

class FirstScreen extends StatelessWidget {
  String? jwt;

  @override
  Widget build(BuildContext context) {
    _getPrefs().then((value) {
      jwt = value.getString("jwt");
    });
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: SplashScreen());
        } else {
          if (jwt == null) {
            return const MaterialApp(home: WelcomeScreen());
          } else {
            return  MaterialApp(
              home: Homepage(selectedIndex: 0),
            );
          }
        }
      },
    );
  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/cow.png"),
          ],
        ));
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
