import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  final Widget? child;
  const Background({
    Key? key,
    this.child
  }) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.fill)),
    );
  }
}
