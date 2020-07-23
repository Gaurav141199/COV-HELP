import 'package:cov_help/Screens/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:cov_help/services/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cov_help/services/User.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Cov-help",
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: kPrimaryColor,
          ),
        ),
        home: HomeController(),
      ),
    );
  }
}

class HomeController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    String name = '';
    String email = '';
    String uid = '';

    Future<String> get() async{
      name = await auth.getUserName();
      email = await auth.getEmail();
      uid = await auth.getCurrentUID();
      return 'success';
    }


    Future _future = get();

    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active){
          final bool signedIn = snapshot.hasData;
          return  (signedIn) ? FutureBuilder(
            future: _future,
            builder: (context, snapshot){
              if(snapshot.hasData){
                user1.name = name;
                user1.email = email;
                user1.uid = uid;
                return Main_page(name: name, email: email, uid: uid,);
              }else return SpinKitDoubleBounce(
                color: kPrimaryColor,
                size: 50,
              );
            },
          ): WelcomeScreen();
        }
        return SpinKitDoubleBounce(
          color: kPrimaryColor,
          size: 50.0,
        );
      },
    );
  }
}