import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/constants.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Live_Count extends StatefulWidget {
  Live_Count() : super();
  @override
  _Live_CountState createState() => _Live_CountState();
}

class _Live_CountState extends State<Live_Count> {
  final String Current_cases_Url = "https://api.covid19india.org/data.json";
  List data1;

  Future<String> _future;

  @override
  void initState() {
    _future = getJsonData();
    super.initState();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(Current_cases_Url),
    );
    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }

    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data1 = convertDataToJson["statewise"];
    });
    return "success";
  }


  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    int _current = 0;
    CarouselSlider carouselSlider;
    Size size = MediaQuery.of(context).size;
    List<String> required_list= ["active", "confirmed", "deaths", "recovered"];

    goToPrevious() {
      carouselSlider.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }

    goToNext() {
      carouselSlider.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.decelerate);
    }

    return Container(
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return  Column(
                children: <Widget>[
                  Container(
                    width: size.width*0.9,
                    height: 140.0,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.08),
                          spreadRadius: 5,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 20.0,
                          width: size.width*0.9,
                        ),
                        Container(
                          height: 30,
                          width: size.width*0.95,
                          child: Text(
                              "  Across India",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                        Container(
                          height: 10.0,
                          width: size.width*0.95,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 70,
                              width: size.width*0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 12.0,),
                                  Text(
                                    'Confirmed',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    (data1[0]["confirmed"] == null)? "0": data1[0]["confirmed"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              width: size.width*0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 12.0,),
                                  Text(
                                    'Active',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    (data1[0]["active"] == null)? "0": data1[0]["active"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              width: size.width*0.27,
                              decoration: BoxDecoration(


                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 12.0,),
                                  Text(
                                    'Deceased',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    (data1[0]["deaths"] == null)? "0": data1[0]["deaths"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: size.width*0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        carouselSlider = CarouselSlider(
                          height: 210.0,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          reverse: false,
                          enableInfiniteScroll: true,
                          autoPlayInterval: Duration(seconds: 4),
                          autoPlayAnimationDuration: Duration(milliseconds: 1000),
                          pauseAutoPlayOnTouch: Duration(seconds: 10),
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index) {
                            setState(() {
                              _current = index;
                            });
                          },
                          items: data1.map((value) {
                            int index = data1.indexOf(value);
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple.withOpacity(0.08),
                                        spreadRadius: 5,
                                        blurRadius: 3,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Center(
                                        child: Text(
                                          data1[index]["state"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            child: Center(
                                              child: Text(
                                                'Confirmed',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                data1[index]["confirmed"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            child: Center(
                                              child: Text(
                                                  'Recovered',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                data1[index]["recovered"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            child: Center(
                                              child: Text(
                                                  '  Active ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                data1[index]["active"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            child: Center(
                                              child: Text(
                                                  ' Deaths  ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                data1[index]["deaths"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),


                      ],
                    ),
                  )
                ],
              );
            }
            else {
              return Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width*0.9,
                      height: 140.0,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.08),
                          spreadRadius: 5,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      ),
                      child: SpinKitCubeGrid(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        )
    );

    }
}
