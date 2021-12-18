import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/screens/register/components/body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Body(),
    );
  }
}


