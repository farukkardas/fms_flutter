import 'package:flutter/material.dart';
import 'package:fms_flutter/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  const RoundedInputField({Key? key, this.hintText, this.icon, this.onChanged, this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(controller:textEditingController ,
            onChanged: onChanged,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                constraints: BoxConstraints.tight(const Size(0, 40)),
                icon: Icon(
                  icon,
                  color: Colors.black,
                ))));
  }
}
