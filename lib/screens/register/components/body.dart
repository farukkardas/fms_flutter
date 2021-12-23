import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fms_flutter/components/already_have_an_account.dart';
import 'package:fms_flutter/components/custom_button.dart';
import 'package:fms_flutter/components/rounded_input_field.dart';
import 'package:fms_flutter/components/rounded_password_field.dart';
import 'package:fms_flutter/guards/auth_guard.dart';
import 'package:fms_flutter/models/auth/register_model.dart';
import 'package:fms_flutter/screens/homepage/homepage.dart';
import 'package:fms_flutter/screens/login/login_screen.dart';
import 'package:fms_flutter/screens/register/register_screen.dart';
import 'package:fms_flutter/services/auth_service.dart';

class Body extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  late bool isAuth;
  RegisterModel registerModel = RegisterModel();
  String? message;

  FutureOr Function()? returnHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Homepage()),
      (Route<dynamic> route) => false,
    );
  }

  registerAccount() async {
    AuthService authService = AuthService();
    authService
        .register(registerModel: registerModel)
        .then((result) => setState(() {
              if (result.message!.contains("Successfully")) {
                final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      result.message!,
                      textAlign: TextAlign.center,
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // Return homepage after 2 sec
                var timer =
                    Timer(const Duration(seconds: 2), () => returnHomePage());
              } else {
                print(result.message);
                final snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      result.message!,
                      textAlign: TextAlign.center,
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }));
  }

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                const Text("REGISTER",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const Image(
                  image: AssetImage("assets/images/bull.png"),
                  height: 150,
                ),
                buildFirstNameInput(),
                buildLastNameInput(),
                buildEmailInput(),
                buildPasswordInput(),
                const SizedBox(
                  height: 5,
                ),
                CustomButton(
                  text: "Register",
                  color: Colors.black,
                  textColor: Colors.white,
                  press: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    formKey.currentState?.save();
                    registerAccount();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                AlreadyHaveAccountField(
                  login: false,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordInput() {
    return RoundedPassword(validator: (value) {
      if (value.isEmpty || value == null) {
        return message = "Password cannot be empty!";
      } else if (value.length > 50) {
        return message = "Password cannot be larger than 50 letters!";
      } else if (value.length < 8) {
        return message = "Password cannot be smaller than 8 letters!";
      }
    }, onSaved: (value) async {
      registerModel.password = value;
    });
  }

  Widget buildEmailInput() {
    return RoundedInputField(
      validator: (value) {
        if (value.isEmpty || value == null) {
          return message = "Email cannot be empty!";
        } else if (!value.contains("@")) {
          return message = "Email format is not true!";
        } else if (value.length > 300) {
          return message = "Email cannot be larger than 300 letters!";
        } else if (value.length < 10) {
          return message = "Email cannot be smaller than 10 letters!";
        }
      },
      hintText: "Email..",
      icon: Icons.person,
      onSaved: (value) async {
        registerModel.email = value;
      },
    );
  }

  Widget buildLastNameInput() {
    return RoundedInputField(
      validator: (value) {
        if (value.isEmpty || value == null) {
          return message = "Last name cannot be empty!";
        } else if (value.length > 40) {
          return message = "Last name cannot be larger than 40 letters!";
        } else if (value.length < 2) {
          return message = "Last name cannot be smaller than 2 letters!";
        }
      },
      hintText: "Surname..",
      icon: Icons.create_rounded,
      onSaved: (value) async {
        registerModel.lastName = value;
      },
    );
  }

  Widget buildFirstNameInput() {
    return RoundedInputField(
      validator: (value) {
        if (value.isEmpty || value == null) {
          return message = "First name cannot be empty!";
        } else if (value.length > 40) {
          return message = "First name cannot be larger than 40 letters!";
        } else if (value.length < 2) {
          return message = "First name be smaller than 2 letters!";
        }
      },
      hintText: "Name..",
      icon: Icons.create_rounded,
      onSaved: (value) async {
        registerModel.firstName = value;
      },
    );
  }
}
