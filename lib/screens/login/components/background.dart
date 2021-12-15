import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget? child;
  const Background({
    Key? key,
    this.child
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.fill)),
    );
  }
}
