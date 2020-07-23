import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Signup/signup_screen.dart';
import 'package:cov_help/Screens/Welcome/components/background.dart';
import 'package:cov_help/Screens/donor_page_1/donor_page1.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/Screens/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> questions = ["I was a COVID Positive patient.", "I am now negative after infection.", "I have been cured for 14 days.", "I am healthy and feeling excited to donate plasma.", "I am between 18-60 years of age."];
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50 ,
              width:  size.width*0.9,
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              child: Center(
                child: Text(
                  "Am I eligible to Donate ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 300,
              width: size.width*0.9,

              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: <Widget>[
                          Text(
                            "->  " + questions[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: kPrimaryColor,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            RoundedButton(
              text: "YES, I AM ELIGIBLE",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Donor_page_1();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "NO, I CAN'T DONATE NOW",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                 Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
