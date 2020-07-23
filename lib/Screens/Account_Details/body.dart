import 'dart:ui';
import 'package:cov_help/services/User.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Login/components/background.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cov_help/services/authentication.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User user = User();
  String _name = "";
  String _email = "";
  String phone_number = "";
  String blood_group = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text('U'),
            ),
            Text(''),
          ],
        ),
      ),
    );
  }

}