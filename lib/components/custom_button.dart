import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color color, textColor;

  CustomButton(
      {Key? key, required this.text, this.press, required this.color, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Colors.black, width: 3)),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              color: color,
              focusColor: Colors.red,
              onPressed: press,
              child: Text(
                text,
                style: TextStyle(color: textColor),
              )),
        ));
  }
}
