import 'package:cov_help/Screens/Signup/components/verification_screen.dart';
import 'package:cov_help/Screens/Signup/signup_screen.dart';
import 'package:cov_help/Screens/main_page/main_page.dart';
import 'package:cov_help/services/navigation_Service.dart';
import 'package:flutter/material.dart';

const String SignupRoute = 'signup';
// const String LoginRoute = 'login';
const String HomeRoute = 'home';
const String VerificationRoute = 'verify';

Route<dynamic> generateRoute(RouteSettings settings) {
  final ScreenArguments args = settings.arguments;
  String name = args.name;
  String email = args.email;
  String uid = args.uid;
  String password = args.password;

  switch (settings.name) {
    case SignupRoute:
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    case HomeRoute:
      return MaterialPageRoute(
          builder: (context) => Main_page(
                name: name,
                email: email,
                uid: uid,
              ));
    case VerificationRoute:
      return MaterialPageRoute(
          builder: (context) => VerificationScreen(
                name: name,
                email: email,
                password: password,
              ));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
