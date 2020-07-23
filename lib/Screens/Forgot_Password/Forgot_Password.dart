import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Welcome/components/background.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Forgot_Password extends StatelessWidget {
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
  String email1 = '';

  Color bg_color = kPrimaryLightColor;

  Color border_color = kPrimaryLightColor;

  Color icon_color = kPrimaryColor;

  bool loading = false;

  Future<String> submit() async{
    final auth = Provider.of(context).auth;
    String uid = '';
    try {
      setState(() {
        loading = true;
      });
      await auth.sendPasswordResetEmail(email1);
      Fluttertoast.showToast(
        msg: 'Verification mail has been sent',
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
    }catch (e){
      if(e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.'){
        Fluttertoast.showToast(
          msg: 'Couldn\'t find email',
        );
      }else {
        Fluttertoast.showToast(
          msg: 'An error occured',
        );
      }
      print(e);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Center(
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
                  press: () async {
                    email1 = email1.trim();
                    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email1)){
                      print(email1);
                      await submit();
                    }else{
                      Fluttertoast.showToast(
                        msg: 'Email Format Incorrect',
                      );
                      border_color = Colors.red;
                      icon_color = Colors.red;
                      bg_color = Colors.white;
                      setState(() {});
                    }
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
