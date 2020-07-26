import 'package:cov_help/Screens/Help_line/Help_line.dart';
import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:cov_help/Screens/donor_page_0/donor_page0.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Change_Password.dart';
import 'Myheader/header.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/main_page/Components/Background.dart';
import 'package:cov_help/Screens/main_page/Components/livecount_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:cov_help/Screens/main_page/Components/Cancel.dart';
import 'package:cov_help/services/User.dart';


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

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      text: "CANCEL REGISTRATION",
      color: kPrimaryLightColor,
      press: (){
      }

    );
  }
}

//bool hey = false;

class empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}


class empty2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      width: 0
    );
  }
}

class Body extends StatefulWidget {
  final String name;
  final String email;
  final String uid;
  const Body({Key key, this.name, this.email, this.uid}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();

}

class _BodyState extends State<Body> {
  List<String> drawer_list = ["Change Password", "Download Aarogya Setu App", "State wise Helpline", "Log out"];
  List<IconData> icon_list = [Icons.update, Icons.file_download, Icons.headset_mic, Icons.exit_to_app ];
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  String hospital;
  
//  void get_hospital() async{
//    DatabaseReference db = await FirebaseDatabase.instance.reference().child('hopsital');
//
//  }


  bool show_cancel = true;

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    bool next = false;

    bool one = false;
    void cancel_reg() async{
      DatabaseReference Database = FirebaseDatabase.instance.reference();
      try {
        await Database.child('users').child(widget.uid).once().then((DataSnapshot snapshot) {
          hospital = snapshot.value['hospital'];
        });
        one= true;
      }catch(e){
        Fluttertoast.showToast(msg: 'Try Again.');
        one = false;
      }
      if(one) {
        try {
          await Database.child('users').child(widget.uid).update({
            'phone_hospital': null,
            'state_hospital': null,
            'hospital': null,
            'date': null,
            'time': null,
          });
        } catch (e) {
          Fluttertoast.showToast(msg: "Try Again.");
        }
      }
    }

    void cancel_reg2() async{
      DatabaseReference db = await FirebaseDatabase.instance.reference();
      try {
        await db.child('user_list').child(hospital).update({
          widget.uid: null,
        });
        show_cancel = false;
      }catch(e){
        Fluttertoast.showToast(msg: 'Try Again');
      }
    }

    String uid = '';

    final AuthService auth = Provider.of(context).auth;
//
//    void submit() async{
//      try {
//        uid = await auth.getCurrentUID();
//      } catch(e){
//        Fluttertoast.showToast(msg: 'Try Again');
//      }
//    }
//
//    DatabaseReference db = FirebaseDatabase.instance.reference().child('users');
//
//    bool check_prev = false;
//
//    void check() async{
//      try{
//        await db.child(uid).once().then((DataSnapshot snapshot) {
//          print(snapshot.value);
//          if(snapshot.value['date'] == null) check_prev = true;
//          else check_prev = false;
//        }
//        );
//      }catch(e){
//        Fluttertoast.showToast(msg: 'Try Again');
//      }
//    }

    void logout() async {
      setState(() {
        loading = true;
      });
      try {
        await auth.signOut();
        next = true;
      }catch(e){
        Fluttertoast.showToast(msg: 'Try Again');
        next = false;
      }
      user1.email = null;
      user1.name = null;
      user1.uid = null;
      setState(() {
        loading = false;
      });
    }


      Size size = MediaQuery.of(context).size;

      return Stack(
        children: <Widget>[
          Background(
            drawer_widget: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      currentAccountPicture: new CircleAvatar(
                        child: Text(
                            widget.name[0],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                      ),
                      accountName: Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                      ),
                      accountEmail: Text(widget.email,
                          style: TextStyle(
                              fontSize: 16
                          )
                      ),
                    ),
                    Container(
                      height: size.height*0.5,
                      child: ListView.builder(
                          itemCount: drawer_list.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        drawer_list[index],
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                                icon_list[index],
                                              textDirection: TextDirection.ltr,

                                            ),
                                          ),

                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                              onTap: () async {
                                if(index == 0){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Change_Password();
                                      },
                                    ),
                                  );
                                }else if(index == 1){
                                  _launchInBrowser('https://play.google.com/store/apps/details?id=nic.goi.aarogyasetu&hl=en_IN');
                                }else if(index == 2){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Help_line();
                                      },
                                    ),
                                  );
                                }else if(index == 3) {
                                  await logout();
                                  if(next) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WelcomeScreen()),
                                          (Route<dynamic> route) => false,
                                    );
                                  }
                                }
                              }
                              ,
                            );
                          }
                      ),
                    )
                  ],

                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  MyHeader(
                    image: "assets/icons/Drcorona.svg",
                    textTop: "All you need",
                    textBottom: "is stay at home.",
                    offset: 0,
                  ),
                  SizedBox(height: size.height*0.05 ),
                  Live_Count(),
                  RoundedButton(
                    text: "DONATE",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Donor_page0();
                          },
                        ),
                      );
                    },
                  ),
                  (show_cancel)? Cancel(
                    uid: widget.uid,
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      await cancel_reg();
                      await cancel_reg2();
                      print(show_cancel);
                      print(loading);
                      setState(() {
                        loading = false;
                      });
                      Fluttertoast.showToast(msg: 'Cancelled');
                    },
                  ): empty2(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width : size.width*0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryLightColor,
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image(
                        image: AssetImage('assets/images/safety.jpeg'),
                        width: size.width*0.85,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.05),
                ],
              ),
            ),
          ),
          (loading)? indicator(): empty(),
        ],
      );
  }
}
