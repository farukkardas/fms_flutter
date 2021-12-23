import 'package:flutter/material.dart';
import 'package:fms_flutter/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final Function(String?) onSaved;
  final TextEditingController? textEditingController;
  final validator;


  const RoundedInputField(
      {Key? key,
      this.hintText,
      this.icon,
      required this.onSaved,
      this.textEditingController, this.validator,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(validator: validator,
            onSaved: onSaved,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                //constraints: BoxConstraints.tight(const Size(0, 40)),
                icon: Icon(
                  icon,
                  color: Colors.black,
                ))));
  }
}
