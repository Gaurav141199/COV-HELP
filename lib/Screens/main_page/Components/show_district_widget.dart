import 'package:flutter/material.dart';

class show_district_widget extends StatefulWidget {
  final int confirmed;
  final String Name;
  final int recovered;
  final int deceased;
  const show_district_widget({Key key, this.confirmed, this.Name, this.recovered, this.deceased}) : super(key: key);
  @override
  _show_district_widgetState createState() => _show_district_widgetState();
}

class _show_district_widgetState extends State<show_district_widget> {

  Widget build(BuildContext context) {
    return Container();
  }
}