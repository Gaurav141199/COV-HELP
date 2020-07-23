import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Welcome/components/background.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Change_Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Center(
        child: Body(),
      ),
    );
  }
}

class indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: SpinKitDoubleBounce(
        color: kPrimaryColor,
        size: 50.0,
      ),
    ));
  }
}

class empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Color bg_color = kPrimaryLightColor;

  Color border_color = kPrimaryLightColor;

  Color icon_color = kPrimaryColor;

  bool loading = false;
  String userEmail;
  Future<String> submit() async{
    final _auth = FirebaseAuth.instance;
    await _auth.currentUser().then((value) => userEmail=value.email);
    final auth = Provider.of(context).auth;
    String uid = '';
    setState(() {
      loading = true;
    });
    await auth.sendPasswordResetEmail(userEmail);
    Fluttertoast.showToast(
      msg: 'Password Reset mail has been sent',
    );
    setState(() {
      bg_color = kPrimaryLightColor;
      border_color = kPrimaryLightColor;
      icon_color = kPrimaryColor;
    });
    await new Future.delayed(new Duration(milliseconds: 1500), ()
    {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (Route<dynamic> route) => false,
      );
    });
    setState(() {
      loading = false;
    });
  }

//  final _auth = FirebaseAuth.instance;
//
//  void getCurrentUserEmail() async {
////    final user =
//    await _auth.currentUser().then((value) => userEmail = value.email);
//  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                RoundedButton(
                  text: 'Send Password Reset Email',
                  press: () async {
//                    getCurrentUserEmail();
                    await submit();

                  }
                ),
                (loading) ? indicator(): empty(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
