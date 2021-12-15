import 'package:flutter/material.dart';

class AlreadyHaveAccountField extends StatelessWidget {
  final bool login = true;
  final Function? press;
  const AlreadyHaveAccountField({
    Key? key, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  <Widget>[
        Text(
          login ? "Don't you have account? " : "Already have an account?",
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 16),
        ),
        GestureDetector(onTap: () {} ,
          child:  Text( login ? "Sign Up" : "Sign In",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        )
      ],
    );
  }
}
