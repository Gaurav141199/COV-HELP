import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: GoogleFonts.roboto(
            color: kPrimaryColor,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
            fontSize: 16.0,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: GoogleFonts.roboto(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              decoration: TextDecoration.none,
            ),
          ),
        )
      ],
    );
  }
}
