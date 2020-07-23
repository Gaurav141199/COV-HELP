import 'package:cov_help/Screens/constants.dart';
import 'package:cov_help/district_rec/body.dart';
import 'package:flutter/material.dart';

//void main(){
//  runApp(Districts());
//}


class Districts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Requirements'),
        ),

        body: Body(),
      ),
    );
  }
}
