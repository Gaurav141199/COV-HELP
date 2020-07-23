import 'dart:ui';
import 'package:cov_help/Screens/main_page/main_page.dart';
import 'package:cov_help/services/User.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';


class Donor_thank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Container(
                width: size.width*0.8,
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'CONFIRMED!',
                        style: GoogleFonts.sortsMillGoudy(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontSize: 26.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: size.height*0.4,
                width: size.width,
                child: Lottie.asset("assets/Animations/teal_heart.json"),
              ),
              Container(
                width: size.width*0.8,
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'THANKS FOR BEING',
                        style: GoogleFonts.sortsMillGoudy(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontSize: 26.0,
                        ),
                      ),
                      Text(
                        'A SAVIOUR!',
                        style: GoogleFonts.sortsMillGoudy(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontSize: 26.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0,),

              RoundedButton(
                color: kPrimaryColor,
                textColor: Colors.white,
                text: 'Go to Home Screen',
                press: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Main_page(name: user1.name,email: user1.email, uid: user1.uid,)),
                        (Route<dynamic> route) => false,
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
