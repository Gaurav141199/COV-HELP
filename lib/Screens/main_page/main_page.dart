import 'package:flutter/cupertino.dart';
import 'package:cov_help/services/User.dart';
import 'package:cov_help/Screens/main_page/Components/body.dart';

class Main_page extends StatefulWidget {
  const Main_page({Key key, this.name, this.email, this.uid}) : super(key: key);

  @override
  _Main_pageState createState() => _Main_pageState();
  final String name;
  final String email;
  final String uid;

}

class _Main_pageState extends State<Main_page> {
  @override
  Widget build(BuildContext context) {
    return Body(
      name: widget.name,
//    name: 'gaurav',
      email: widget.email,
//      email: 'gajdfhl',
      uid: widget.uid,
    );
  }
}
