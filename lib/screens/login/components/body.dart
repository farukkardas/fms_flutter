import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fms_flutter/components/already_have_an_account.dart';
import 'package:fms_flutter/components/custom_button.dart';
import 'package:fms_flutter/components/rounded_input_field.dart';
import 'package:fms_flutter/components/rounded_password_field.dart';
import 'package:fms_flutter/guards/auth_guard.dart';
import 'package:fms_flutter/screens/homepage/homepage.dart';
import 'package:fms_flutter/screens/register/register_screen.dart';
import 'package:fms_flutter/services/auth_service.dart';

class Body extends State {
  Future<String>? response;
  String? message;
  late bool isAuth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    Future.delayed(
        Duration.zero,
        () => AuthGuard().checkIfLogged().then((value) => {
              isAuth = value,print(isAuth),
              if (isAuth == false)
                {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const Homepage();
                  }), (route) => false)
                }
            }));
    FutureOr Function()? returnHomePage() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
        (Route<dynamic> route) => false,
      );
    }

    loginAccount() async {
      AuthService authService = AuthService();

      authService
          .login(
              emailController: emailController,
              passwordController: passwordController)
          .then((result) => {
                setState(() {
                  message = result.toString();
                  // if success
                  if (message!.contains("Successfully")) {
                    final snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          message!,
                          textAlign: TextAlign.center,
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // Return homepage after 2 sec
                    var timer = Timer(
                        const Duration(seconds: 2), () => returnHomePage());
                  } else {
                    final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          message!,
                          textAlign: TextAlign.center,
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                })
              });
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 80),
              const Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              SizedBox(height: size.height * 0.03),
              const Image(image: AssetImage("assets/images/sheep.png")),
              RoundedInputField(
                textEditingController: emailController,
                hintText: "Email..",
                icon: Icons.person,
                onChanged: (value) {},
              ),
              RoundedPassword(
                  textEditingController: passwordController,
                  onChanged: (value) {}),
              const SizedBox(height: 5),
              CustomButton(
                text: "Login",
                color: Colors.black,
                textColor: Colors.white,
                press: () {
                  loginAccount();
                },
              ),
              const SizedBox(height: 15),
              AlreadyHaveAccountField(
                  login: true,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegisterScreen();
                    }));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
