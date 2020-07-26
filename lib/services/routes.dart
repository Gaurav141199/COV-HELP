import 'package:cov_help/Screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';

const String SignupRoute = 'signup';
// const String HomeRoute = 'Home';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignupRoute:
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    // case HomeRoute:
    //   return MaterialPageRoute(builder: (context) => HomeView());
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
