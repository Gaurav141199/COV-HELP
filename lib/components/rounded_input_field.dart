import 'package:flutter/material.dart';
import 'package:cov_help/components/text_field_container.dart';
import 'package:cov_help/Screens/constants.dart';

class RoundedInputField extends StatelessWidget {
  final Color border_color;
  final double radius1;
  final String hintText;
  final IconData icon;
  final Color color1;
  final ValueChanged<String> onChanged;
  final Color icon_color;
  const RoundedInputField({
    Key key,
    this.icon_color,
    this.color1,
    this.radius1,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.border_color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      border_color: this.border_color,
      color2: color1,
      radius: radius1,
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: (icon_color == null) ? kPrimaryColor: icon_color,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
