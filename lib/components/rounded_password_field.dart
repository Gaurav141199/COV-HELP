import 'package:flutter/material.dart';
import 'package:cov_help/components/text_field_container.dart';
import 'package:cov_help/Screens/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final String text;
  final Color bg_color;
  final Color border_color;
  final Color icon_color;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.bg_color,
    this.border_color,
    this.icon_color,
    this.text,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => new _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      border_color: widget.border_color,
      color2: widget.bg_color,
      child: TextField(
        obscureText: _isHidden,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: (widget.text == null) ? "Password" : widget.text,
          icon: Icon(
            Icons.lock,
            color: (widget.icon_color == null) ? kPrimaryColor: widget.icon_color,
          ),
          suffixIcon: IconButton(
            color:  kPrimaryColor,
            onPressed: (){
              _toggleVisibility();
            },
            icon: _isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off,
              color: kPrimaryColor,),

          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
