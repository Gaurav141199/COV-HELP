import 'dart:ui';

import 'package:cov_help/Screens/Login/components/background.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Body extends StatelessWidget {
  List<String> phone = ["tel://03192232102",""
      "tel://08662410978",
    "tel://9436055743",
    "tel://6913347770",
    "tel://104",
    "tel://9779558282",
    "tel://104",
    "tel://104",
    "tel://01122307145",
    "tel://104",
    "tel://104",
    "tel://8558893911",
    "tel://104",
    "tel://01912520982",
    "tel://104",
    "tel://104",
    "tel://01942440283",
    "tel://04712552056",
    "tel://104",
    "tel://104",
    "tel://02026127394",
    "tel://3852411668",
    "tel://108",
    "tel://102",
    "tel://7005539653",
    "tel://9439994859",
    "tel://104",
    "tel://104",
    "tel://01412225624",
    "tel://104",
    "tel://04429510500",
    "tel://104",
    "tel://03812315879",
    "tel://104",
    "tel://18001805145",
    "tel://03323412600"];

  List<String> states = [
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



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            shrinkWrap: true,
          itemCount: states.length,
            itemBuilder: (context, index){
              return Column(
                children: <Widget>[
                  Container(
                    width: size.width*0.7,
                    height: 40,
//                    color: kPrimaryLightColor,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryLightColor,
                          spreadRadius: 5,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: size.width*0.3,
                            child: Text(states[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                        ),
                        Container(
                          width: size.width*0.3,
                          child: GestureDetector(
                            onTap: (){
                              launch(phone[index]);
                            },
                            child: Text(
                              phone[index].substring(6,phone[index].length),
                              style: TextStyle(
                                color: Color(0xFF0000EE),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)
                ],

              );
            }
        ),
      ),
    );
  }
}
