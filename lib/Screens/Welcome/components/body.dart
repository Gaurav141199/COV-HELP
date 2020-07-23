import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Login/login_screen.dart';
import 'package:cov_help/Screens/Signup/signup_screen.dart';
import 'package:cov_help/Screens/Welcome/components/background.dart';
import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:flutter_svg/svg.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
home: Body1(),
//      initialRoute: '/',
//      routes: {
//        '/': (context)=> Body1(),
//        '/login_donor': (context) => LoginScreen(),
//      },
    );
  }
}



class Body1 extends StatelessWidget {
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
              "COV-HELP",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN AS DONOR",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen(null);
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
