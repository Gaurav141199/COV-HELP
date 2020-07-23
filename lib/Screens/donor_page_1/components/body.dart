import 'dart:ui';
import 'package:cov_help/Screens/Register/Register.dart';
import 'package:cov_help/Screens/hospital_donation/hospital_donation.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Welcome/components/background.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "BE A CORONA WARRIOR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            Text(
                'We will contact you when required',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor
              )
            ),
            RoundedButton(
              text: "Register as Donor",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Register();
                    },
                  ),
                );
              },
            ),
            Text(
                'Go and Donate to Plasma Bank',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor
                )
            ),
            RoundedButton(
              text: "Donate to Plasma Bank",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AtHospital();
                    },
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
