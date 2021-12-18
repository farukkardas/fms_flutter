import 'package:flutter/material.dart';
import 'package:fms_flutter/components/text_field_container.dart';

class RoundedPassword extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  const RoundedPassword({
    Key? key, this.onChanged, this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(controller: textEditingController ,
            obscureText: true,
            onChanged: onChanged,
            decoration: const InputDecoration(hintText: "Password..",
                icon: Icon(Icons.lock, color: Colors.black),
                suffixIcon: Icon(Icons.visibility, color: Colors.black),
                border: InputBorder.none)));
  }
}
