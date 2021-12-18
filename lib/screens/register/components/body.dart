import 'package:flutter/material.dart';
import 'package:fms_flutter/components/already_have_an_account.dart';
import 'package:fms_flutter/components/custom_button.dart';
import 'package:fms_flutter/components/rounded_input_field.dart';
import 'package:fms_flutter/screens/login/login_screen.dart';
import 'package:fms_flutter/screens/register/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            const Text("REGISTER",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Image(
              image: AssetImage("assets/images/bull.png"),
              height: 150,
            ),
            RoundedInputField(
              hintText: "Name..",
              icon: Icons.create_rounded,
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Surname..",
              icon: Icons.create_rounded,
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Email..",
              icon: Icons.person,
              onChanged: (value) {},
            ),
            RoundedInputField(
                hintText: "Password..", icon: Icons.lock, onChanged: (value) {}),
            RoundedInputField(
              hintText: "Password again..",
              icon: Icons.lock,
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 5,
            ),
            CustomButton(
              text: "Register",
              color: Colors.black,
              textColor: Colors.white,
              press: () {},
            ),const SizedBox(
              height: 15,
            ),
            AlreadyHaveAccountField(
              login: false,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
