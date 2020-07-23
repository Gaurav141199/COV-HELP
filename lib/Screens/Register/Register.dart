import 'dart:ui';

import 'package:cov_help/Screens/donor_confirm.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/donor_thank/donor_thank.dart';
import 'package:cov_help/components/rounded_button.dart';
import 'package:cov_help/components/rounded_input_field.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cov_help/services/Provider.dart';

class indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(child: SpinKitDoubleBounce(
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


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  static List<String> andhra_list = ["Anantapur", "Chittoor", "East Godavari", "Guntur", "Krishna", "Kurnool", "Prakasam", "Srikakulam", "Sri Potti Sriramulu Nellore", "Visakhapatnam", "Vizianagaram", "West Godavari", "YSR District", "Kadapa"] ;

  static List<String> arunachal = ["Anjaw", "Changlang", "Dibang Valley", "East Kameng", "East Siang", "Kamle" "Kra Daadi", "Kurung Kumey", "Lepa Rada", "Lohit", "Longding", "Lower Dibang Valley", "Lower Siang", "Lower Subansiri", "Namsai", "Pakke Kessang", "Papum Pare", "Shi Yomi", "Siang", "Tawang", "Tirap", "Upper Siang", "Upper Subansiri", "West Kameng", "West Siang"] ;

  static List<String> assam = ["Baksa", "Barpeta", "Biswanath", "Bongaigaon", "Cachar", "Charaideo", "Chirang", "Darrang", "Dhemaji", "Dhubri", "Dibrugarh", "Dima Hasao (North Cachar Hills)", "Goalpara", "Golaghat", "Hailakandi", "Hojai", "Jorhat", "Kamrup", "Kamrup Metropolitan", "Karbi Anglong", "Karimganj", "Kokrajhar", "Lakhimpur", "Majuli", "Morigaon", "Nagaon", "Nalbari", "Sivasagar", "Sonitpur", "South Salamara-Mankachar", "Tinsukia", "Udalguri", "West Karbi Anglong"];

  static List<String> bihar = ["Araria", "Arwal", "Aurangabad", "Banka", "Begusarai", "Bhagalpur", "Bhojpur", "Buxar", "Darbhanga", "East Champaran (Motihari)", "Gaya", "Gopalganj", "Jamui", "Jehanabad", "Kaimur (Bhabua)", "Katihar", "Khagaria", "Kishanganj", "Lakhisarai", "Madhepura", "Madhubani", "Munger (Monghyr)", "Muzaffarpur", "Nalanda", "Nawada", "Patna", "Purnia (Purnea)", "Rohtas", "Saharsa", "Samastipur", "Saran", "Sheikhpura", "Sheohar", "Sitamarhi", "Siwan", "Supaul", "Vaishali", "West Champaran"];

  static List<String> chattisgarh= ["Balod", "Baloda Bazar", "Balrampur", "Bastar", "Bemetara", "Bijapur", "Bilaspur", "Dantewada (South Bastar)", "Dhamtari", "Durg", "Gariyaband", "Janjgir-Champa", "Jashpur", "Kabirdham (Kawardha)", "Kanker (North Bastar)", "Kondagaon", "Korba", "Korea (Koriya)", "Mahasamund", "Mungeli", "Narayanpur", "Raigarh", "Raipur", "Rajnandgaon", "Sukma", "Surajpur", "Surguja"];

  static List<String> delhi = ["Central Delhi", "East Delhi", "New Delhi", "North Delhi", "North East Delhi", "North West Delhi", "Shahdara", "South Delhi", "South East Delhi", "South West Delhi", "West Delhi"];
  static List<String> goa = ["Goa", "South Goa"];

  static List<String> gujarat = ["Ahmedabad", "Amreli", "Anand", "Aravalli", "Banaskantha (Palanpur)", "Bharuch", "Bhavnagar", "Botad", "Chhota Udepur", "Dahod", "Dangs (Ahwa)", "Devbhoomi Dwarka", "Gandhinagar", "Gir Somnath", "Jamnagar", "Junagadh", "Kachchh", "Kheda (Nadiad)", "Mahisagar", "Mehsana", "Morbi", "Narmada (Rajpipla)", "Navsari", "Panchmahal (Godhra)", "Patan", "Porbandar", "Rajkot", "Sabarkantha (Himmatnagar)", "Surat", "Surendranagar", "Tapi (Vyara)", "Vadodara", "Valsad"];

  static List<String> haryana = ["Ambala", "Bhiwani", "Charkhi Dadri", "Faridabad", "Fatehabad", "Gurugram (Gurgaon)", "Hisar", "Jhajjar", "Jind", "Kaithal", "Karnal", "Kurukshetra", "Mahendragarh", "Nuh", "Palwal", "Panchkula", "Panipat", "Rewari", "Rohtak", "Sirsa", "Sonipat", "Yamunanagar"];

  static List<String> himachal = ["Bilaspur", "Chamba", "Hamirpur", "Kangra", "Kinnaur", "Kullu", "Lahaul & Spiti", "Mandi", "Shimla", "Sirmaur (Sirmour)", "Solan", "Una"];

  static List<String> jammu = ["Anantnag", "Bandipore", "Baramulla", "Budgam", "Doda", "Ganderbal", "Jammu", "Kargil", "Kathua", "Kishtwar", "Kulgam", "Kupwara", "Leh", "Poonch", "Pulwama", "Rajouri", "Ramban", "Reasi", "Samba", "Shopian", "Srinagar", "Udhampur"];

  static List<String> jharkhand = ["Bokaro", "Chatra", "Deoghar", "Dhanbad", "Dumka", "East Singhbhum", "Garhwa", "Giridih", "Godda", "Gumla", "Hazaribag", "Jamtara", "Khunti", "Koderma", "Latehar", "Lohardaga", "Pakur", "Palamu", "Ramgarh", "Ranchi", "Sahibganj", "Seraikela-Kharsawan", "Simdega", "West Singhbhum"];

  static List<String> karnataka = ["Bagalkot", "Ballari (Bellary)", "Belagavi (Belgaum)", "Bengaluru (Bangalore) Rural", "Bengaluru (Bangalore) Urban", "Bidar", "Chamarajanagar", "Chikballapur", "Chikkamagaluru (Chikmagalur)", "Chitradurga", "Dakshina Kannada", "Davangere", "Dharwad", "Gadag", "Hassan", "Haveri", "Kalaburagi (Gulbarga)", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru (Mysore)", "Raichur", "Ramanagara", "Shivamogga (Shimoga)", "Tumakuru (Tumkur)", "Udupi", "Uttara Kannada (Karwar)", "Vijayapura (Bijapur)", "Yadgir"];

  static List<String> kerala = ["Alappuzha", " Ernakulam", " Idukki", " Kannur", " Kasaragod", " Kollam", " Kottayam", " Kozhikode", " Malappuram", " Palakkad", " Pathanamthitta", " Thiruvananthapuram", " Thrissur", " Wayanad"];

  static List<String> lakshwadeep = ["Lakshwadeep"];

  static List<String> madhya = ["Agar Malwa", "Alirajpur", "Anuppur", "Ashoknagar", "Balaghat", "Barwani", "Betul", "Bhind", "Bhopal", "Burhanpur", "Chhatarpur", "Chhindwara", "Damoh", "Datia", "Dewas", "Dhar", "Dindori", "Guna", "Gwalior", "Harda", "Hoshangabad", "Indore", "Jabalpur", "Jhabua", "Katni", "Khandwa", "Khargone", "Mandla", "Mandsaur", "Morena", "Narsinghpur", "Neemuch", "Niwari", "Panna", "Raisen", "Rajgarh", "Ratlam", "Rewa", "Sagar", "Satna", "Sehore", "Seoni", "Shahdol", "Shajapur", "Sheopur", "Shivpuri", "Sidhi", "Singrauli", "Tikamgarh", "Ujjain", "Umaria", "Vidisha"];

  static List<String> maharashtra = ["Ahmednagar", "Akola", "Amravati", "Aurangabad", "Beed", "Bhandara", "Buldhana", "Chandrapur", "Dhule", "Gadchiroli", "Gondia", "Hingoli", "Jalgaon", "Jalna", "Kolhapur", "Latur", "Mumbai City", "Mumbai Suburban", "Nagpur", "Nanded", "Nandurbar", "Nashik", "Osmanabad", "Palghar", "Parbhani", "Pune", "Raigad", "Ratnagiri", "Sangli", "Satara", "Sindhudurg", "Solapur", "Thane", "Wardha", "Washim", "Yavatmal"];

  static List<String> manipur = ["Bishnupur", "Chandel", "Churachandpur", "Imphal East", "Imphal West", "Jiribam", "Kakching", "Kamjong", "Kangpokpi", "Noney", "Pherzawl", "Senapati", "Tamenglong", "Tengnoupal", "Thoubal", "Ukhrul"];

  static List<String> megha = ["East Garo Hills", "East Jaintia Hills", "East Khasi Hills", "North Garo Hills", "Ri Bhoi", "South Garo Hills", "South West Garo Hills", "South West Khasi Hills", "West Garo Hills", "West Jaintia Hills", "West Khasi Hills"];

  static List<String> mizo = ["Aizawl", "Champhai", "Kolasib", "Lawngtlai", "Lunglei", "Mamit", "Saiha", "Serchhip"];
  static List<String> naga = ["Dimapur", "Kiphire", "Kohima", "Longleng", "Mokokchung", "Mon", "Peren", "Phek", "Tuensang", "Wokha", "Zunheboto"];

  static List<String> odisha = ["Angul", "Balangir", "Balasore", "Bargarh", "Bhadrak", "Boudh", "Cuttack", "Deogarh", "Dhenkanal", "Gajapati", "Ganjam", "Jagatsinghapur", "Jajpur", "Jharsuguda", "Kalahandi", "Kandhamal", "Kendrapara", "Kendujhar (Keonjhar)", "Khordha", "Koraput", "Malkangiri", "Mayurbhanj", "Nabarangpur", "Nayagarh", "Nuapada", "Puri", "Rayagada", "Sambalpur", "Sonepur", "Sundargarh"];

  static List<String> punjab = ["Amritsar", "Barnala", "Bathinda", "Faridkot", "Fatehgarh Sahib", "Fazilka", "Ferozepur", "Gurdaspur", "Hoshiarpur", "Jalandhar", "Kapurthala", "Ludhiana", "Mansa", "Moga", "Muktsar", "Nawanshahr (Shahid Bhagat Singh Nagar)", "Pathankot", "Patiala", "Rupnagar", "Sahibzada Ajit Singh Nagar (Mohali)", "Sangrur", "Tarn Taran"];

  static List<String> raj = ["Ajmer", "Alwar", "Banswara", "Baran", "Barmer", "Bharatpur", "Bhilwara", "Bikaner", "Bundi", "Chittorgarh", "Churu", "Dausa", "Dholpur", "Dungarpur", "Hanumangarh", "Jaipur", "Jaisalmer", "Jalore", "Jhalawar", "Jhunjhunu", "Jodhpur", "Karauli", "Kota", "Nagaur", "Pali", "Pratapgarh", "Rajsamand", "Sawai Madhopur", "Sikar", "Sirohi", "Sri Ganganagar", "Tonk", "Udaipur"];

  static List<String> sikkim = ["East Sikkim", "North Sikkim", "South Sikkim", "West Sikkim"];

  static List<String> tamil = ["Ariyalur", "Chengalpattu", "Chennai", "Coimbatore", "Cuddalore", "Dharmapuri", "Dindigul", "Erode", "Kallakurichi", "Kanchipuram", "Kanyakumari", "Karur", "Krishnagiri", "Madurai", "Nagapattinam", "Namakkal", "Nilgiris", "Perambalur", "Pudukkottai", "Ramanathapuram", "Ranipet", "Salem", "Sivaganga", "Tenkasi", "Thanjavur", "Theni", "Thoothukudi (Tuticorin)", "Tiruchirappalli", "Tirunelveli", "Tirupathur", "Tiruppur", "Tiruvallur", "Tiruvannamalai", "Tiruvarur", "Vellore", "Viluppuram", "Virudhunagar"];

  static List<String> telangana = ["Adilabad", "Bhadradri Kothagudem", "Hyderabad", "Jagtial", "Jangaon", "Jayashankar Bhoopalpally", "Jogulamba Gadwal", "Kamareddy", "Karimnagar", "Khammam", "Komaram Bheem Asifabad", "Mahabubabad", "Mahabubnagar", "Mancherial", "Medak", "Medchal", "Nagarkurnool", "Nalgonda", "Nirmal", "Nizamabad", "Peddapalli", "Rajanna Sircilla", "Rangareddy", "Sangareddy", "Siddipet", "Suryapet", "Vikarabad", "Wanaparthy", "Warangal (Rural)", "Warangal (Urban)", "Yadadri Bhuvanagiri"];

  static List<String> tripura = ["Dhalai", "Gomati", "Khowai", "North Tripura", "Sepahijala", "South Tripura", "Unakoti", "West Tripura"];

  static List<String> uttarakhan = ["Almora", "Bageshwar", "Chamoli", "Champawat", "Dehradun", "Haridwar", "Nainital", "Pauri Garhwal", "Pithoragarh", "Rudraprayag", "Tehri Garhwal", "Udham Singh Nagar", "Uttarkashi"];

  static List<String> uttar = ["Agra", "Aligarh", "Allahabad", "Ambedkar Nagar", "Amethi (Chatrapati Sahuji Mahraj Nagar)", "Amroha (J.P. Nagar)", "Auraiya", "Azamgarh", "Baghpat", "Bahraich", "Ballia", "Balrampur", "Banda", "Barabanki", "Bareilly", "Basti", "Bhadohi", "Bijnor", "Budaun", "Bulandshahr", "Chandauli", "Chitrakoot", "Deoria", "Etah", "Etawah", "Faizabad", "Farrukhabad", "Fatehpur", "Firozabad", "Gautam Buddha Nagar", "Ghaziabad", "Ghazipur", "Gonda", "Gorakhpur", "Hamirpur", "Hapur (Panchsheel Nagar)", "Hardoi", "Hathras", "Jalaun", "Jaunpur", "Jhansi", "Kannauj", "Kanpur Dehat", "Kanpur Nagar", "Kanshiram Nagar", "Kaushambi", "Kushinagar (Padrauna)", "Lakhimpur - Kheri", "Lalitpur", "Lucknow", "Maharajganj", "Mahoba", "Mainpuri", "Mathura", "Mau", "Meerut", "Mirzapur", "Moradabad", "Muzaffarnagar", "Pilibhit", "Pratapgarh", "RaeBareli", "Rampur", "Saharanpur", "Sambhal (Bhim Nagar)", "Sant Kabir Nagar", "Shahjahanpur", "Shamali (Prabuddh Nagar)", "Shravasti", "Siddharth Nagar", "Sitapur", "Sonbhadra", "Sultanpur", "Unnao", "Varanasi"];

  static List<String> west = ["Alipurduar", "Bankura", "Birbhum", "Cooch Behar", "Dakshin Dinajpur (South Dinajpur)", "Darjeeling", "Hooghly", "Howrah", "Jalpaiguri", "Jhargram", "Kalimpong", "Kolkata", "Malda", "Murshidabad", "Nadia", "North 24 Parganas", "Paschim Medinipur (West Medinipur)", "Paschim (West) Burdwan (Bardhaman)", "Purba Burdwan (Bardhaman)", "Purba Medinipur (East Medinipur)", "Purulia", "South 24 Parganas", "Uttar Dinajpur (North Dinajpur)"];

  String blood = '';

  Map<String, List<String>> map = {
    "Andaman and Nicobar Island": [
      "Nicobar",
      "North and Middle Andaman",
      "South Andaman"
    ],
    "Andhra Pradesh": andhra_list,
    "Arunachal Pradesh": arunachal,
    "Assam": assam,
    "Bihar": bihar,
    "Chandigarh": ["Chandigarh"],
    "Chhattisgarh": chattisgarh,
    "Dadra and Nagar Haveli": ["Dadra and Nagar Haveli"],
    "Daman and Diu": ["Daman and Diu"],
    "Delhi":delhi,
    "Goa":goa,
    "Gujarat":gujarat,
    "Haryana":haryana,
    "Himachal Pradesh": himachal,
    "Jammu and Kashmir":jammu,
    "Jharkhand":jharkhand,
    "Karnataka":karnataka,
    "Kerala":kerala,
    "Lakshadweep": lakshwadeep,
    "Madhya Pradesh":madhya,
    "Maharashtra":maharashtra,
    "Manipur":manipur,
    "Meghalaya":megha,
    "Mizoram":mizo,
    "Nagaland":naga,
    "Odisha":odisha,
    "Puducherry": ["Karaikal", "Mahe", "Puducherry", "Yanam"],
    "Punjab":punjab,
    "Rajasthan":raj,
    "Sikkim":sikkim,
    "Tamil Nadu":tamil,
    "Telangana":telangana,
    "Tripura":tripura,
    "Uttarakhand":uttarakhan,
    "Uttar Pradesh":uttar,
    "West Bengal":west,
  };

  bool next = false;
  bool one = false;
  bool two = false;
  bool three = false;

  static String uid = "";
  void submit() async {
    try{
      final auth = Provider.of(context).auth;
      uid = await auth.getCurrentUID();
      print(uid);

      one = true;
    } catch(e){
      print(e);
        Fluttertoast.showToast(msg: 'Try Again.');
    }
  }



  final Database = FirebaseDatabase.instance.reference().child('users');

  void read() async{
      await Database.child(uid).once().then((DataSnapshot datasnapshot) {
        blood = datasnapshot.value['blood'];
        print(blood);
      });
  }

  void writeData () async {
      await Database.child(uid).update({
        'phone': _phone,
        'state': _state,
        'district': _district,
        'address1': _city,
        'address2': _address,
      });
  }

  final Database2 = FirebaseDatabase.instance.reference().child('donor');

  void donor() async {
    await Database2.child(_state).child(_district).child(blood).push().set(uid);
    next = true;
  }

  String _phone = "";
  String _state = "";
  String _district = "";
  String _city = "";
  String _address = "";
  List<DropdownMenuItem<String>> state_list = new List<DropdownMenuItem<String>> ();

  List<bool> check_list = [false, false, false, false, false, false, false];
  List<Color> color_list = [kPrimaryColor, kPrimaryColor, kPrimaryColor, kPrimaryColor, kPrimaryColor,kPrimaryColor, kPrimaryColor ];
  List<Color> bg_color_list = [Colors.white, Colors.white, kPrimaryLightColor, kPrimaryLightColor, kPrimaryLightColor, kPrimaryLightColor, kPrimaryLightColor];
  List<Color> border_color  = [kPrimaryLightColor, kPrimaryLightColor, kPrimaryLightColor, kPrimaryLightColor, kPrimaryLightColor];

  void create_list(){
    state_list = new List<DropdownMenuItem<String>> ();
    map.forEach((key, value) {
      DropdownMenuItem<String> item1 = DropdownMenuItem<String>(value: key,
          child: Container(
              child: Text(key)
          )
      );
      state_list.add(item1);
    });
  }


  List<DropdownMenuItem<String>> dist_list = new List<DropdownMenuItem<String>> ();

  void create_list2(List<String> list){
    dist_list = new List<DropdownMenuItem<String>> ();
    for(int i = 0; i < list.length; ++i){
      DropdownMenuItem<String> item1 = DropdownMenuItem<String>(value: list[i], child: Container(child: Text(list[i])));
      dist_list.add(item1);
    };
  }

  void initState(){
    create_list();
  }

  bool loading = false;


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                'Be A Saviour'
            ),
          ),
          body: SingleChildScrollView(

            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.center,
                  width: size.width*0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      Container(
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                          color: bg_color_list[2],
                          border: Border.all(
                            color: border_color[0],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              items: state_list,
                              onChanged: (_value){
                                if(check_list[3]){
                                  check_list[3] = false;
                                };

                                _state = _value;
                                check_list[2] = true;
                                setState(() {
                                  create_list2(map[_state]);
                                });
                              },
                              hint: Text(
                                (check_list[2]) ? _state: 'Select State',
                                style: TextStyle(
                                  color: color_list[2],
                                  fontWeight: (check_list[2])?  FontWeight.bold: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.0,),
                      Container(
                        width: size.width*0.8,
                        decoration: BoxDecoration(

                          color: bg_color_list[3],
                          border: Border.all(
                            color: border_color[1],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              items: dist_list,
                              onChanged: (_value){
                                check_list[3] = true;
                                _district = _value;
                                setState(() {
                                });
                                print(_value.toString());
                              },
                              hint: Text(
                                (check_list[3])? _district: 'Select District',
                                style: TextStyle(
                                  color: color_list[3],
                                  fontWeight: (check_list[3])?  FontWeight.bold: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.0,),

                      RoundedInputField(
                        border_color: border_color[2],
                        icon_color: color_list[4],
                        color1: bg_color_list[4],
                        radius1: 5,
                        icon: Icons.home,
                        hintText: "Address Line 1",
                        onChanged: (value) {
                          if(value.length > 0)check_list[4] = true;
                          _city = value;
                        },
                      ),

                      RoundedInputField(
                        border_color: border_color[3],
                        icon_color: color_list[5],
                        color1: bg_color_list[5],
                        radius1: 5,
                        icon: Icons.location_city,
                        hintText: "Address Line 2",
                        onChanged: (value) {
                          if(value.length > 0)check_list[5] = true;
                          _address = value;
                        },
                      ),

                      RoundedInputField(
                        border_color: border_color[4],
                        icon_color: color_list[6],
                        color1: bg_color_list[6],
                        radius1: 5,
                        icon: Icons.phone,
                        hintText: "Phone Number",
                        onChanged: (value) {
                          if(value.length == 10)check_list[6] = true;
                          _phone = value;
                        },
                      ),

                      RoundedButton(
                        text: "REGISTER AS A DONOR",
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        press: () async {
                          if(!check_list[2]){
                            color_list[2] = Colors.red[800];
                            bg_color_list[2] = Colors.white;
                            border_color[0] = Colors.red;
                          }else {
                            color_list[2] = kPrimaryColor;
                            bg_color_list[2] = kPrimaryLightColor;
                            border_color[0] = kPrimaryLightColor;
                          }
                          if(!check_list[3]){
                            color_list[3] = Colors.red[800];
                            bg_color_list[3] = Colors.white;
                            border_color[1] = Colors.red;
                          }else {
                            color_list[3] = kPrimaryColor;
                            bg_color_list[3] = kPrimaryLightColor;
                            border_color[1] = kPrimaryLightColor;
                          }
                          if(!check_list[4]){
                            color_list[4] = Colors.red[800];
                            bg_color_list[4] = Colors.white;
                            border_color[2] = Colors.red;
                          }else{
                            color_list[4] = kPrimaryColor;
                            bg_color_list[4] = kPrimaryLightColor;
                            border_color[2] = kPrimaryLightColor;
                          }
                          if(!check_list[5]){
                            color_list[5] = Colors.red[800];
                            bg_color_list[5] = Colors.white;
                            border_color[3] = Colors.red;
                          }else{
                            color_list[5] = kPrimaryColor;
                            bg_color_list[5] = kPrimaryLightColor;
                            border_color[3] = kPrimaryLightColor;
                          }
                          if(!check_list[6]){
                            color_list[6] = Colors.red[800];
                            bg_color_list[6] = Colors.white;
                            border_color[4] = Colors.red;
                            Fluttertoast.showToast(msg: 'Phone Number is not 10 digits');
                          }else{
                            color_list[6] = kPrimaryColor;
                            bg_color_list[6] = kPrimaryLightColor;
                            border_color[4] = kPrimaryLightColor;
                          }

                          if(check_list[2] && check_list[3] && check_list[4] && check_list[5]){
                            print('enter');
                            setState(() {
                              loading = true;
                            });
                            await submit();
                            await read();
                            await writeData();
                            await donor();
                            setState(() {
                              loading = false;
                            });
                            if(next) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Donor_confirm()),
                                    (Route<dynamic> route) => false,
                              );
                            }
                          }
                          setState(() {
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        (loading)? indicator(): empty(),
      ],
    );;
  }
}
