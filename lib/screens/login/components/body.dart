import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fms_flutter/components/already_have_an_account.dart';
import 'package:fms_flutter/components/custom_button.dart';
import 'package:fms_flutter/components/rounded_input_field.dart';
import 'package:fms_flutter/components/rounded_password_field.dart';
import 'package:fms_flutter/guards/auth_guard.dart';
import 'package:fms_flutter/models/auth/login.dart';
import 'package:fms_flutter/screens/homepage/homepage.dart';
import 'package:fms_flutter/screens/login/login_screen.dart';
import 'package:fms_flutter/screens/register/register_screen.dart';
import 'package:fms_flutter/services/auth_service.dart';

class Body extends State<LoginScreen> {
  Future<String>? response;
  String? message;
  late bool isAuth;
  var formKey = GlobalKey<FormState>();
  Login loginModel = Login();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future.delayed(
        Duration.zero,
        () => AuthGuard().checkIfLogged().then((value) => {
              isAuth = value,
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
      authService.login(loginModel: loginModel).then((result) => {
            if (mounted)
              {
                setState(() {
                  print(result.success);
                  // if success
                  if (result.success == true) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    final snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          result.message!,
                          textAlign: TextAlign.center,
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // Return homepage after 2 sec
                  } else if (result.success == false) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          result.message!,
                          textAlign: TextAlign.center,
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                })
              }
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
          child: Form(
            key: formKey,
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
                buildRoundedInputField(),
                buildRoundedPassword(),
                const SizedBox(height: 5),
                CustomButton(
                  text: "Login",
                  color: Colors.black,
                  textColor: Colors.white,
                  press: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    formKey.currentState?.save();
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
      ),
    );
  }

  Widget buildRoundedPassword() {
    return RoundedPassword(validator: (value) {
      if (value == null || value.isEmpty) {
        return message = "Password input can't be empty!";
      }
    }, onSaved: (value) async {
      loginModel.password = value;
    });
  }

  Widget buildRoundedInputField() {
    return RoundedInputField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return message = "Email input can't be empty!";
        } else if (!value.contains("@")) {
          return message = "This is not valid email!";
        }
      },
      hintText: "Email..",
      icon: Icons.person,
      onSaved: (value) async {
        loginModel.email = value;
      },
    );
  }
}
