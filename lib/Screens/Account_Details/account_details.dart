import 'dart:ui';

import 'package:cov_help/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Login/components/background.dart';
import 'package:cov_help/Screens/Account_Details/body.dart';

class AccountDet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: ProfileView(),
    );
  }
}
