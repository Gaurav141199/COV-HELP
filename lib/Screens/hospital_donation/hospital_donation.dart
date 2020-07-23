import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/donor_thank/donor_thank.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/components/rounded_input_field.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cov_help/services/Provider.dart';
import 'dart:convert';

class AtHospital extends StatefulWidget {
  @override
  _AtHospitalState createState() => _AtHospitalState();
}

class indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: SpinKitDoubleBounce(
        color: kPrimaryColor,
        size: 50.0,
      )),
    );
  }
}

class empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}

class _AtHospitalState extends State<AtHospital> {
  static List<String> west = [
    "Alipurduar",
    "Bankura",
    "Birbhum",
    "Cooch Behar",
    "Dakshin Dinajpur (South Dinajpur)",
    "Darjeeling",
    "Hooghly",
    "Howrah",
    "Jalpaiguri",
    "Jhargram",
    "Kalimpong",
    "Kolkata",
    "Malda",
    "Murshidabad",
    "Nadia",
    "North 24 Parganas",
    "Paschim Medinipur (West Medinipur)",
    "Paschim (West) Burdwan (Bardhaman)",
    "Purba Burdwan (Bardhaman)",
    "Purba Medinipur (East Medinipur)",
    "Purulia",
    "South 24 Parganas",
    "Uttar Dinajpur (North Dinajpur)"
  ];

  static List<String> times = [
    "9 AM - 11 AM",
    "11 AM - 1 PM",
    "1 PM - 3 PM",
    "3 PM - 5 PM"
  ];

  List<DropdownMenuItem<String>> state_list =
      new List<DropdownMenuItem<String>>();
  List<DropdownMenuItem<String>> time_list =
      new List<DropdownMenuItem<String>>();

  String blood = '';

  bool one = false;
  static String uid = "";
  void submit() async {
    try {
      final auth = Provider.of(context).auth;
      uid = await auth.getCurrentUID();
      print(uid);
      one = true;
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'Try Again1.');
    }
  }

  bool check_prev = false;

  void check() async {
    DatabaseReference Database1 =
        await FirebaseDatabase.instance.reference().child('users');
    try {
      await Database.child(uid).once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        if (snapshot.value['date'] != null)
          check_prev = true;
        else
          check_prev = false;
        print(check_prev);
      });
    } catch (e1) {
      Fluttertoast.showToast(msg: 'Try Again2');
    }
  }

  bool next = false;

  static List<String> states = [
    "Andaman and Nicobar Island",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu",
    "Jharkhand",
    "Karnataka",
    "Kashmir",
    "Kerala",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Puducherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal"
  ];

  final Database = FirebaseDatabase.instance.reference().child('users');

  void writeData() async {
    try {
      await Database.child(uid).update({
        'phone_hospital': _phone,
        'state_hospital': _state,
        'hospital': _hospital,
        'date': _date,
        'time': _time,
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Try Again3');
    }
  }

  bool has_plasma = false;
  List<String> hospitals = new List();

  bool loading_state = false;

  void read() async {
    DatabaseReference Database =
        FirebaseDatabase.instance.reference().child('Hospital').child(_state);
    hospitals = new List();
    try {
      await Database.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> map = snapshot.value;
        if (map == null)
          has_plasma = false;
        else {
          has_plasma = true;
          map.forEach((key, value) {
            hospitals.add(key);
          });
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Try Again4');
    }
    print(hospitals);
    create_list2();
    setState(() {});
  }

  void user_list() async {
    DatabaseReference Database = FirebaseDatabase.instance
        .reference()
        .child('user_list')
        .child(_hospital);
    try {
      await Database.set({
        uid: uid,
      });
      next = true;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Try Again5');
    }
    print(hospitals);
    create_list2();
    setState(() {});
  }

  String _phone = "";
  static String _state = "Not Set";
  String _hospital = "";
  String _date = "Not Set";
  String _time = "Not set";

  List<bool> check_list = [false, false, false, false, false];
  List<Color> color_list = [
    kPrimaryColor,
    kPrimaryColor,
    kPrimaryColor,
    kPrimaryColor,
    kPrimaryColor
  ];
  List<Color> bg_color_list = [
    Colors.white,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor
  ];
  List<Color> border_color = [
    Colors.white,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor
  ];

  void create_list() {
    state_list = new List<DropdownMenuItem<String>>();
    for (int i = 0; i < states.length; i++) {
      DropdownMenuItem<String> item1 = DropdownMenuItem<String>(
          value: states[i], child: Container(child: Text(states[i])));
      state_list.add(item1);
    }
    ;
  }

  List<DropdownMenuItem<String>> hosp_list =
      new List<DropdownMenuItem<String>>();

  void create_list2() {
    hosp_list = new List<DropdownMenuItem<String>>();
    for (int i = 0; i < hospitals.length; ++i) {
      DropdownMenuItem<String> item1 = DropdownMenuItem<String>(
          value: hospitals[i],
          child: Container(
            child: Text(hospitals[i]),
          ));
      hosp_list.add(item1);
    }
    ;
  }

  void create_list_time() {
    time_list = new List<DropdownMenuItem<String>>();
    for (int i = 0; i < times.length; ++i) {
      DropdownMenuItem<String> item1 = DropdownMenuItem<String>(
          value: times[i], child: Container(child: Text(times[i])));
      time_list.add(item1);
    }
    ;
  }

  void initState() {
    create_list();
    create_list_time();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Be A Saviour'),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.center,
                  width: size.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 4.0,
                        onPressed: () {
                          // DatePicker.showDatePicker(context,
                          //     theme: DatePickerTheme(
                          //       containerHeight: 210.0,
                          //     ),
                          //     showTitleActions: true,
                          //     minTime: DateTime(1900, 1, 1),
                          //     maxTime: DateTime(2100, 12, 31),
                          //     onConfirm: (date) {
                          //       print('confirm $date');
                          //       _date = '${date.year} - ${date.month} - ${date.day}';
                          //       check_list[0] = true;
                          //       setState(() {
                          //         bg_color_list[0] = Colors.white;
                          //         color_list[0] = kPrimaryColor;
                          //         border_color[0] = Colors.white;
                          //       });
                          //     },
                          //     currentTime: DateTime.now(),
                          //     locale: LocaleType.en
                          // );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          size: 18.0,
                                          color: color_list[0],
                                        ),
                                        Text(
                                          "$_date",
                                          style: TextStyle(
                                              color: color_list[0],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "  Change",
                                style: TextStyle(
                                    color: color_list[0],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        color: bg_color_list[0],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: bg_color_list[1],
                          border: Border.all(
                            color: border_color[1],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              items: time_list,
                              onChanged: (_value) {
                                print(_value);
                                _time = _value;
                                check_list[1] = true;
                                setState(() {
                                  color_list[1] = kPrimaryColor;
                                  bg_color_list[1] = kPrimaryLightColor;
                                  border_color[1] = kPrimaryLightColor;
                                });

//                      print(_value.toString());
                              },
                              hint: Text(
                                (check_list[1]) ? _time : 'Select Time',
                                style: TextStyle(
                                  color: color_list[1],
                                  fontWeight: (check_list[1])
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: bg_color_list[2],
                          border: Border.all(
                            color: border_color[2],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              items: state_list,
                              onChanged: (_value) async {
                                loading_state = true;
                                setState(() {
                                  color_list[3] = kPrimaryColor;
                                  bg_color_list[3] = kPrimaryLightColor;
                                  border_color[3] = kPrimaryLightColor;
                                });
                                _state = _value;
                                check_list[2] = true;
                                await read();
                                if (!has_plasma)
                                  Fluttertoast.showToast(
                                      msg:
                                          'Your State does not have a Plasma Bank');
                                loading_state = false;
                                setState(() {
                                  color_list[2] = kPrimaryColor;
                                  bg_color_list[2] = kPrimaryLightColor;
                                  border_color[2] = kPrimaryLightColor;
                                });
                              },
                              hint: Text(
                                (check_list[2]) ? _state : 'Select State',
                                style: TextStyle(
                                  color: color_list[2],
                                  fontWeight: (check_list[2])
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: bg_color_list[3],
                          border: Border.all(
                            color: border_color[3],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              items: hosp_list,
                              onChanged: (_value) {
                                print(_value);
                                check_list[3] = true;
                                _hospital = _value;
                                setState(() {});
                                print(_value.toString());
                              },
                              hint: Text(
                                (check_list[3]) ? _hospital : 'Select Hospital',
                                style: TextStyle(
                                  color: color_list[3],
                                  fontWeight: (check_list[3])
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RoundedInputField(
                        border_color: border_color[4],
                        icon_color: color_list[4],
                        color1: bg_color_list[4],
                        radius1: 5,
                        icon: Icons.phone,
                        hintText: "Phone Number",
                        onChanged: (value) {
                          if (value.length == 10) check_list[4] = true;
                          _phone = value;
                        },
                      ),
                      RoundedButton(
                        text: "SCHEDULE YOUR APPOINTMENT",
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        press: () async {
                          if (!check_list[0]) {
                            color_list[0] = Colors.red[800];
                            bg_color_list[0] = Colors.white;
                            border_color[0] = Colors.red;
                          } else {
                            color_list[0] = kPrimaryColor;
                            bg_color_list[0] = kPrimaryLightColor;
                            border_color[0] = kPrimaryLightColor;
                          }
                          if (!check_list[1]) {
                            color_list[1] = Colors.red[800];
                            bg_color_list[1] = Colors.white;
                            border_color[1] = Colors.red;
                          } else {
                            color_list[1] = kPrimaryColor;
                            bg_color_list[1] = kPrimaryLightColor;
                            border_color[1] = kPrimaryLightColor;
                          }
                          if (!check_list[2]) {
                            color_list[2] = Colors.red[800];
                            bg_color_list[2] = Colors.white;
                            border_color[2] = Colors.red;
                          } else {
                            color_list[2] = kPrimaryColor;
                            bg_color_list[2] = kPrimaryLightColor;
                            border_color[2] = kPrimaryLightColor;
                          }
                          if (!check_list[3]) {
                            if (check_list[2]) {
                              color_list[3] = Colors.red[800];
                              bg_color_list[3] = Colors.white;
                              border_color[3] = Colors.red;
                            }
                          } else {
                            color_list[3] = kPrimaryColor;
                            bg_color_list[3] = kPrimaryLightColor;
                            border_color[3] = kPrimaryLightColor;
                          }
                          if (!check_list[4]) {
                            color_list[4] = Colors.red[800];
                            bg_color_list[4] = Colors.white;
                            border_color[4] = Colors.red;
                            Fluttertoast.showToast(
                                msg: 'Phone Number is not 10 digits');
                          } else {
                            color_list[4] = kPrimaryColor;
                            bg_color_list[4] = kPrimaryLightColor;
                            border_color[4] = kPrimaryLightColor;
                          }
                          setState(() {});

                          if (check_list[0] &&
                              check_list[1] &&
                              check_list[2] &&
                              check_list[3] &&
                              check_list[4]) {
                            setState(() {
                              loading_state = true;
                            });
                            await submit();
                            await check();
                            if (!check_prev) {
                              if (one) await writeData();
                              await user_list();
                              setState(() {
                                loading_state = false;
                              });

                              if (next) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Donor_thank()),
                                  (Route<dynamic> route) => false,
                                );
                              }
                              ;
                            } else {
                              setState(() {
                                loading_state = false;
                              });
                              Fluttertoast.showToast(
                                  msg:
                                      'Already registered. To change first cancel the previous one');
                            }
                          }

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        (loading_state) ? indicator() : empty(),
      ],
    );
    ;
  }
}
