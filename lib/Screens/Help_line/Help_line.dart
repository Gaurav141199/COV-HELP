import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Help_line/Body.dart';

class Help_line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('State Helpline Numbers'),
        centerTitle: true,
      ),
      resizeToAvoidBottomPadding: false,
      body: Body(),
    );
  }
}
