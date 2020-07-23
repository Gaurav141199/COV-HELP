import 'package:flutter/material.dart';
import 'package:cov_help/Screens/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Color border_color;
  final Color color2;
  final Widget child;
  final double radius;
  const TextFieldContainer({
    Key key,
    this.color2,
    this.radius,
    this.child,
    this.border_color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(
          color: (border_color ==null) ? kPrimaryLightColor: border_color,
        ),
        color:(color2 == null)? kPrimaryLightColor: color2,
        borderRadius: (radius == null) ? BorderRadius.circular(29): BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
