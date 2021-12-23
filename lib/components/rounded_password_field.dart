import 'package:flutter/material.dart';
import 'package:fms_flutter/components/text_field_container.dart';

class RoundedPassword extends StatelessWidget {
  final Function(String?) onSaved;
  final TextEditingController? textEditingController;
  final validator;

  const RoundedPassword(
      {Key? key,
      required this.onSaved,
      this.textEditingController,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
            validator: validator,
            obscureText: true,
            onSaved: onSaved,
            decoration: const InputDecoration(
                hintText: "Password..",
                icon: Icon(Icons.lock, color: Colors.black),
                suffixIcon: Icon(Icons.visibility, color: Colors.black),
                border: InputBorder.none)));
  }
}
