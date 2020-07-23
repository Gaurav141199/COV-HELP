import 'package:cov_help/Screens/Signup/components/verification_screen.dart';
import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Login/login_screen.dart';
import 'package:cov_help/Screens/Signup/components/background.dart';
import 'package:cov_help/components/already_have_an_account_acheck.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/components/rounded_input_field.dart';
import 'package:cov_help/components/rounded_password_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Welcome/welcome_screen.dart';

import '../../constants.dart';

class Body extends StatefulWidget {
  final _key = GlobalKey();
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Body1(widget._key),
    );
  }
}

class indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: SpinKitDoubleBounce(
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

class Body1 extends StatefulWidget {
  Body1(GlobalKey<State<StatefulWidget>> key);

  @override
  _Body1State createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  List<String> blood_group_list1 = [
    "O+ve",
    "O-ve",
    "A+ve",
    "A-ve",
    "B+ve",
    "B-ve",
    "AB+ve",
    "AB-ve"
  ];

  List<DropdownMenuItem<String>> blood_group_list =
      new List<DropdownMenuItem<String>>();

  List<bool> check_list = [false, false, false, false, false];
  List<Color> bg = [
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor
  ];
  List<Color> border = [
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor
  ];
  List<Color> text = [null, kPrimaryColor, null, null, null];

  void create_list() {
    blood_group_list = new List<DropdownMenuItem<String>>();
    for (int i = 0; i < blood_group_list1.length; ++i) {
      DropdownMenuItem<String> item1 = DropdownMenuItem<String>(
          value: blood_group_list1[i],
          child: Container(child: Text(blood_group_list1[i])));
      blood_group_list.add(item1);
    }
  }

  void initState() {
    create_list();
  }

  String _name = '';

  String _email = '';

  String _password = '';

  String _confirm = '';

  String blood = '';

  bool email_valid = false;

  List<bool> _signup = [false, false, false, false, false];

  bool loading = false;

  bool log = false;
  bool one = false;

  bool name_checker(String name) {
    if (name.length > 0) {
      name = name[0].toUpperCase() + name.substring(1);
      print(name);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    String uid = "";

    Future<String> submit() async {
      try {
        final auth = Provider.of(context).auth;
        uid =
            await auth.createUserWithEmailAndPassword(_email, _password, _name);
        if (uid != null) {
          print(uid);
          setState(() {
            one = true;
          });
          return uid;
        } else {
          setState(() {
            one = false;
          });
          return null;
        }
      } catch (e) {
        print(e);
        if (e.message == 'The email address is badly formatted.') {
          Fluttertoast.showToast(msg: 'Email address badly formatted.');
        } else if (e.message ==
            'The email address is already in use by another account.') {
          Fluttertoast.showToast(msg: 'Email Already exists');
        } else {
          Fluttertoast.showToast(msg: 'Try Again.');
        }
        setState(() {
          one = false;
        });
        return null;
      }
    }

    final Database = FirebaseDatabase.instance.reference().child('users');

    void writeData() async {
      print(uid);
      await Database.child(uid).set({
        'name': _name,
        'blood': blood,
        'email': _email,
      });
      log = true;
    }

    void logout() async {
      await Provider.of(context).auth.signOut();
    }

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40.0),
                Text(
                  "SIGNUP",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.35,
                ),
                RoundedInputField(
                  border_color: border[0],
                  color1: bg[0],
                  icon_color: text[0],
                  icon: Icons.account_box,
                  hintText: "Name",
                  onChanged: (value) {
                    if (value.length > 0) check_list[0] = true;
                    if (value.length > 0)
                      _name = value[0].toUpperCase() + value.substring(1);
                    print(_name);
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 60,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: bg[1],
                    border: Border.all(
                      color: border[1],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(29),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 0.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          items: blood_group_list,
                          onChanged: (_value) {
                            blood = _value;
                            check_list[1] = true;
                            setState(() {});
                          },
                          hint: TextField(
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.local_hospital,
                                color: text[1],
                              ),
                              hintText: (check_list[1]) ? blood : 'Blood Group',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                RoundedInputField(
                  border_color: border[2],
                  icon_color: text[2],
                  color1: bg[2],
                  hintText: "Your Email",
                  onChanged: (value) {
                    check_list[2] = true;
                    _email = value;
                  },
                ),
                RoundedPasswordField(
                  border_color: border[3],
                  icon_color: text[3],
                  bg_color: bg[3],
                  onChanged: (value) {
                    check_list[3] = true;
                    _password = value;
                  },
                ),
                RoundedPasswordField(
                  border_color: border[4],
                  icon_color: text[4],
                  bg_color: bg[4],
                  text: "Confirm Password",
                  onChanged: (value) {
                    check_list[4] = true;
                    _confirm = value;
                  },
                ),
                RoundedButton(
                    text: "SIGNUP",
                    press: () async {
                      if (!(name_checker(_name) && check_list[0])) {
                        bg[0] = Colors.white;
                        border[0] = Colors.red;
                        text[0] = Colors.red;
                        setState(() {});
                        _signup[0] = false;
                      } else {
                        bg[0] = kPrimaryLightColor;
                        border[0] = kPrimaryLightColor;
                        text[0] = kPrimaryColor;
                        setState(() {});
                        _signup[0] = true;
                      }
                      if (!check_list[1]) {
                        bg[1] = Colors.white;
                        border[1] = Colors.red;
                        text[1] = Colors.red;
                        setState(() {});
                        _signup[1] = false;
                      } else {
                        bg[1] = kPrimaryLightColor;
                        border[1] = kPrimaryLightColor;
                        text[1] = kPrimaryColor;
                        setState(() {});
                        _signup[1] = true;
                      }
                      if (!check_list[2]) {
                        bg[2] = Colors.white;
                        border[2] = Colors.red;
                        text[2] = Colors.red;
                        setState(() {});
                        _signup[2] = false;
                      } else {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_email)) {
                          bg[2] = Colors.white;
                          border[2] = Colors.red;
                          text[2] = Colors.red;
                          setState(() {});
                          Fluttertoast.showToast(msg: 'Invalid Email Format');
                          _signup[2] = false;
                          email_valid = false;
                        } else {
                          email_valid = true;
                          bg[2] = kPrimaryLightColor;
                          border[2] = kPrimaryLightColor;
                          text[2] = kPrimaryColor;
                          setState(() {});
                          _signup[2] = true;
                        }
                      }

                      if (_password.length < 6) {
                        if (email_valid)
                          Fluttertoast.showToast(
                              msg: 'Password should be of atleast 6 digits');
                        bg[3] = Colors.white;
                        border[3] = Colors.red;
                        text[3] = Colors.red;
                        bg[4] = Colors.white;
                        border[4] = Colors.red;
                        text[4] = Colors.red;
                        setState(() {});
                        _signup[3] = false;
                        _signup[4] = false;
                      } else {
                        if (_password != _confirm) {
                          bg[3] = Colors.white;
                          border[3] = Colors.red;
                          text[3] = Colors.red;
                          bg[4] = Colors.white;
                          border[4] = Colors.red;
                          text[4] = Colors.red;
                          setState(() {});
                          _signup[3] = false;
                          _signup[4] = false;
                          if (email_valid)
                            Fluttertoast.showToast(
                                msg: 'Passwords do not match');
                        } else {
                          bg[3] = kPrimaryLightColor;
                          border[3] = kPrimaryLightColor;
                          text[3] = kPrimaryColor;
                          bg[4] = kPrimaryLightColor;
                          border[4] = kPrimaryLightColor;
                          text[4] = kPrimaryColor;
                          setState(() {});
                          _signup[3] = true;
                          _signup[4] = true;
                        }
                      }

                      if (_signup[0] &&
                          _signup[1] &&
                          _signup[2] &&
                          _signup[3] &&
                          _signup[4]) {
                        setState(() {
                          loading = true;
                        });
                        print("3");
                        var string = await submit();
                        if (string == null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerificationScreen(
                                email: _email,
                                password: _password,
                                name: _name,
                              ),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                        writeData();
                        print('enter 2');
                        setState(() {
                          loading = false;
                        });
                        print('3');
                        print("done");
                        loading = false;
                        if (log) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(widget.key)),
                            (Route<dynamic> route) => false,
                          );
//                      }
                        }
                      }
                      ;
                    }),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
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
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            (loading) ? indicator() : empty(),
          ],
        ),
      ),
    );
  }
}
