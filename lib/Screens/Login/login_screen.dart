  import 'package:flutter/material.dart';
  import 'package:cov_help/Screens/Login/components/body.dart';

  class LoginScreen extends StatefulWidget {
    LoginScreen(key): super(key:key);

    @override
    _LoginScreenState createState() => _LoginScreenState();
  }

  class _LoginScreenState extends State<LoginScreen> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Body(key: widget.key,),
      );
    }

  }
