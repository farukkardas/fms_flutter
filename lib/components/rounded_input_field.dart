import 'package:flutter/material.dart';
import 'package:fms_flutter/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final Color? iconColor;
  final ValueChanged<String>? onChanged;
  const RoundedInputField({
    Key? key, this.hintText, this.icon, this.onChanged, this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFieldContainer(
        child: TextField(onChanged: onChanged,
            decoration: InputDecoration(border: InputBorder.none,
                hintText: hintText,
                icon: Icon(icon,color: iconColor,)
            )));
  }
}
