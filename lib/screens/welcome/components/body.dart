import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fms_flutter/components/custom_button.dart';
import 'package:fms_flutter/screens/login/login_screen.dart';
import 'package:fms_flutter/screens/register/register_screen.dart';
import 'package:fms_flutter/screens/welcome/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "WELCOME TO LELY",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          const SizedBox(height: 40),
          Image.asset("assets/images/cow.png"),
          const SizedBox(height: 30),
          CustomButton(
              text: "Login",
              color: Colors.white,
              textColor: Colors.black,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              }),
          const SizedBox(height: 30),
          CustomButton(
              text: "Register",
              color: Colors.white,
              textColor: Colors.black,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterScreen();
                }));
              })
        ],
      ),
    ));
  }

  openLoginMenu() {}
}
