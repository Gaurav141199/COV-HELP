import 'dart:ui';
import 'package:cov_help/services/User.dart';
import 'package:cov_help/Screens/Forgot_Password/Forgot_Password.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Login/components/background.dart';
import 'package:cov_help/Screens/Signup/signup_screen.dart';
import 'package:cov_help/components/already_have_an_account_acheck.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/components/rounded_input_field.dart';
import 'package:cov_help/components/rounded_password_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cov_help/Screens/main_page/main_page.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(child: SpinKitDoubleBounce(
        color: kPrimaryColor,
        size: 50.0,
      )),
    );
  }
}

class empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}




class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

void showToast() {
  Fluttertoast.showToast(
      msg: 'Wrong Email/Password',
  );
}

class main extends StatefulWidget {
  @override
  _mainState createState() => _mainState();
}

class _mainState extends State<main> {


  String name;

  String uid;

  String email = "";
  String password = "";
  bool log = false;
  bool loading = false;
  bool forgot_password = false;

  Color email_color = kPrimaryLightColor;
  Color email_color_border = kPrimaryLightColor;
  Color password_color = kPrimaryLightColor;
  Color password_color_border = kPrimaryLightColor;
  Color email_icon_color = kPrimaryColor;
  Color password_icon_colour = kPrimaryColor;

  Future<String> submit() async{
    final auth = Provider.of(context).auth;
    try {
      setState(() {
        loading = true;
      });
      uid = await auth.signInWithEmailAndPassword(email, password);
      name = await auth.getUserName();
    }catch (e) {
      setState(() {
        loading = false;
      });
      if(e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.'){
        Fluttertoast.showToast(
          msg: 'Incorrect Email/Password',
        );
        setState(() {
          forgot_password = true;
        });
      }else if(e.message == 'The password is invalid or the user does not have a password.'){
        Fluttertoast.showToast(
          msg: 'Incorrect Password',
        );
        setState(() {
          forgot_password = true;
        });
      }else if(e.message == 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.'){
        Fluttertoast.showToast(
          msg: 'Please try later',
        );
      }
      else {
        Fluttertoast.showToast(
          msg: 'Problem in Connection',
        );
      }
      print(e);
      return null;
    }
    if(uid == 'NO'){
      Fluttertoast.showToast(
        msg: 'Email not verified',
      );
      setState(() {
        loading = false;
      });
    }else {
      log = true;
    }
    print(log);
    print(uid);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  border_color: email_color_border,
                  color1: email_color,
                  icon_color: email_icon_color,
                  hintText: "Your Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                RoundedPasswordField(
                  border_color: password_color_border,
                  bg_color: password_color,
                  icon_color: password_icon_colour,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    print(email);
                    email = email.trim();
                    if(!EmailValidator.validate(email)){
                      Fluttertoast.showToast(
                        msg: 'Email Format incorrect',
                      );
                      setState(() {
                        email_color_border = Colors.red;
                        email_color = Colors.white;
                        email_icon_color = Colors.red;
                      });
                      if(password.length == 0){
                        setState(() {
                          password_color = Colors.white;
                          password_icon_colour = Colors.red;
                          password_color_border = Colors.red;
                        });
                      }
                    }
                    else {
                      setState(() {
                        email_color_border = kPrimaryLightColor;
                        email_color = kPrimaryLightColor;
                        email_icon_color = kPrimaryColor;
                      });
                      if(password.length > 0) {
                        await submit();
                        user1.uid = uid;
                        user1.email = email;
                        user1.name = name;
                        if (log) {
                          Fluttertoast.showToast(msg: 'Login Successful');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Main_page(name: user1.name,email: user1.email,uid: user1.uid)),
                          );
                        }
                      }else{
                        setState(() {
                          password_color = Colors.white;
                          password_icon_colour = Colors.red;
                          password_color_border = Colors.red;
                        });
                        Fluttertoast.showToast(
                          msg: 'Enter Password',
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: size.height * 0.005),
                (forgot_password) ?
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Forgot_Password();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ):
                Container(
                  height: 0,
                  width: 0,
                ),

                SizedBox(height: size.height * 0.01),
                AlreadyHaveAnAccountCheck(
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
        ),
        (loading) ? indicator():empty(),
      ],
    );;
  }
}


class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return main();
  }
}
