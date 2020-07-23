import 'package:cov_help/Screens/Login/components/background.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/components/rounded_input_field.dart';

import '../constants.dart';

class Body extends StatelessWidget {
  String email1 = '';
  Color bg_color = kPrimaryLightColor;
  Color border_color = kPrimaryLightColor;
  Color icon_color = kPrimaryColor;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              RoundedInputField(
                border_color: border_color,
                icon_color: icon_color,
                color1: bg_color,
                hintText: 'Email ID',
                onChanged: (value){
                  email1 = value;
                },
              ),
              RoundedButton(
                  text: 'Send Verification Email',
                  press: (){
                    email1 = email1.trim();
                    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email1)){

                    }else{
                      border_color = Colors.red;
                      icon_color = Colors.red;
                      bg_color = Colors.white;
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}