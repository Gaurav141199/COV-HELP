import 'package:cov_help/Screens/constants.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:firebase_database/firebase_database.dart';

class Cancel extends StatefulWidget {
  final String uid;
  final Function onTap;

  const Cancel({Key key, this.uid, this.onTap}) : super(key: key);
  @override
  _CancelState createState() => _CancelState();
}

class _CancelState extends State<Cancel> {

  bool check_prev = false;
  Future<String> _future;
  String time2;
  bool stop_loading = false;


  void check1() async{
    final Database = FirebaseDatabase.instance.reference().child('users');
    print('hi');
    try {
      await Database.child(widget.uid).once().then((DataSnapshot datasnapshot) {
        print(datasnapshot.value);
        time2 = datasnapshot.value['time'];
        if (datasnapshot.value['time'] != null) {
          check_prev = true;
        }
        else check_prev = false;
        print(datasnapshot.value);
        print(datasnapshot.value['time']);
        print(check_prev);
      });
    }catch(e){
      print("error" + e);
    }
    stop_loading = true;
  }

  Future<String> check() async{
    await check1();
    return "Success";
  }

  void initState(){
    _future = check();
  }
    @override
  Widget build(BuildContext context) {



    return Container(
      child: FutureBuilder(
          future : _future,
          builder : (context, snapshot){
//            print(snapshot);

            if(snapshot.hasData) {
              if (check_prev) {
                return RoundedButton(
                  text: "CANCEL DONATION AT PLASMA BANK",
                  press: () {
                    widget.onTap();
                  },
                );
              }
              else{
                return Container();
              }
            }
            else{
              if(stop_loading){
                return Container();
              }
              else {
                return SpinKitCubeGrid(
                  color: kPrimaryColor,
                  size: 50,
                );
              }
            }
          }
      ),
    );
  }
}