import 'package:flutter/material.dart';
import 'package:fms_flutter/components/already_have_an_account.dart';
import 'package:fms_flutter/components/custom_button.dart';
import 'package:fms_flutter/components/rounded_input_field.dart';
import 'package:fms_flutter/components/rounded_password_field.dart';
import 'package:fms_flutter/components/text_field_container.dart';
import 'package:fms_flutter/screens/welcome/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          RoundedInputField(
            hintText: "Email..",
            icon: Icons.person,
            iconColor: Colors.black,
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),
          RoundedPassword(onChanged: (value) {}),
          CustomButton(
            text: "Login",
            color: Colors.black,
            textColor: Colors.white,
            press: () {},
          ), const SizedBox(height: 30),
          AlreadyHaveAccountField( press: () {})
        ],
      ),
    );
  }
}

