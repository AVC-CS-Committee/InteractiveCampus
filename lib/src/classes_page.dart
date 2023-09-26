import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interactivemap/src/aboutus_page.dart';
import 'package:interactivemap/main.dart';
import 'package:interactivemap/src/emergency_page.dart';
import 'package:interactivemap/src/faq_page.dart';
import 'package:interactivemap/src/faq_page.dart';
import 'package:interactivemap/src/class_creator.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:interactivemap/src/faq_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassPage extends StatefulWidget {
  @override
  _ClassPage createState() => _ClassPage();
}

class _ClassPage extends State<ClassPage> {

  void initState() {
    loadData();
    super.initState();
  }

  //Color textColor = Color.fromARGB(255, 255, 166, 0);
  Color textColor = Color.fromARGB(255, 0, 140, 255);

  double latitudeClass1 = 34.67613026710341;
  double longitudeClass1 = -118.19203306356845;

  late int class1pick = 0;

  late String classforCords = "Select a class";


  late String class1Select = "Select a class";
  late String class2Select = "Select a class";
  late String class3Select = "Select a class";
  late String class4Select = "Select a class";
  late String class5Select = "Select a class";
  late String class6Select = "Select a class";


  late String class1_Name = "class name";
  late String class2_Name = "class name";
  late String class3_Name = "class name";
  late String class4_Name = "class name";
  late String class5_Name = "class name";
  late String class6_Name = "class name";


  late String class1_Time = "Class Time";
  late String class2_Time = "Class Time";
  late String class3_Time = "Class Time";
  late String class4_Time = "Class Time";
  late String class5_Time = "Class Time";
  late String class6_Time = "Class Time";


  late String class1_Day = "Class Day";
  late String class2_Day = "Class Day";
  late String class3_Day = "Class Day";
  late String class4_Day = "Class Day";
  late String class5_Day = "Class Day";
  late String class6_Day = "Class Day";

  late Map<String, Object> data = {};


  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    setState(() {
      class1Select = prefs.getString('Class1Select') ?? '';
      class2Select = prefs.getString('Class2Select') ?? '';
      class3Select = prefs.getString('Class3Select') ?? '';
      class4Select = prefs.getString('Class4Select') ?? '';
      class5Select = prefs.getString('Class5Select') ?? '';
      class6Select = prefs.getString('Class6Select') ?? '';

      class1_Name = prefs.getString('class1_Name') ?? '';
      class2_Name = prefs.getString('class2_Name') ?? '';
      class3_Name = prefs.getString('class3_Name') ?? '';
      class4_Name = prefs.getString('class4_Name') ?? '';
      class5_Name = prefs.getString('class5_Name') ?? '';
      class6_Name = prefs.getString('class6_Name') ?? '';

      class1_Time = prefs.getString('class1_Time') ?? '';
      class2_Time = prefs.getString('class2_Time') ?? '';
      class3_Time = prefs.getString('class3_Time') ?? '';
      class4_Time = prefs.getString('class4_Time') ?? '';
      class5_Time = prefs.getString('class5_Time') ?? '';
      class6_Time = prefs.getString('class6_Time') ?? '';

      class1_Day = prefs.getString('class1_Day') ?? '';
      class2_Day = prefs.getString('class2_Day') ?? '';
      class3_Day = prefs.getString('class3_Day') ?? '';
      class4_Day = prefs.getString('class4_Day') ?? '';
      class5_Day = prefs.getString('class5_Day') ?? '';
      class6_Day = prefs.getString('class6_Day') ?? '';

      
      var dataString = prefs.getString('data');
      data = dataString != null ? Map<String, Object>.from(jsonDecode(dataString)): {};
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('AVC Interactive Map',
            style: TextStyle(
              //color: Colors.white,
              fontFamily: 'Sans Serif',
            )),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
          const Text('Your Class Schedule',
             textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 166, 0)
              ),
            ),
             Text("Class 1: ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: textColor
                ),
              ),
            const Divider(),
            Row(
              children: [
                Text("Location: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textColor
                  ),
                ),
                Text(class1Select,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Class: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textColor
                  ),
                ),
                Text(class1_Name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Time: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textColor
                  ),
                ),
                Text(class1_Time,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Day: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textColor
                  ),
                ),
                Text(class1_Day,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: (){
                class1pick = 1;
                goPress();
              },
              child: const Text("GO"),
              style: OutlinedButton.styleFrom(), 
            ),
            ListTile(
              title: const Text('Create A class Schedule',
              textAlign: TextAlign.center,
                style: TextStyle(
                )
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassCreator()),
                );
              },
            ),


          ],
        ),
      ),
    );
  }

  void goPress() async{
      if (class1pick == 1){
        classforCords = class1Select;
      }
      else if(class1pick == 2){
        classforCords = class2Select;
      }
      else if(class1pick == 3){
        classforCords = class3Select;
      }
      else if(class1pick == 4){
        classforCords = class4Select;
      }
      else if(class1pick == 5){
        classforCords = class5Select;
      }
      else if(class1pick == 6){
        classforCords = class6Select;
      }


    if (classforCords == 'CSUB/ CSU Bakersfield'){
      latitudeClass1 =  34.680353586506165;
      longitudeClass1 = -118.18506976951421;
    }
    else if (classforCords == 'DL/ Discovery Lab'){
      latitudeClass1 =  34.680452828358916;
      longitudeClass1 = -118.18656003661856;
    }
    else if (classforCords == 'AL/Auto Lab'){
      latitudeClass1 =  34.67882218077683;
      longitudeClass1 = -118.18719722438767;
    }
    else if (classforCords == 'UH/Uhazy Hall'){
      latitudeClass1 =  34.6788359665366;
      longitudeClass1 = -118.18640225876932;
    }
    else if (classforCords == 'YH/Yoshida Hall'){
      latitudeClass1 =  34.67899187744454;
      longitudeClass1 = -118.18548358738202;
    }
    else if (classforCords == 'S1-9/SOAR High School'){
      latitudeClass1 =  34.67877310935158;
      longitudeClass1 = -118.18800679457378;
    }
    else if (classforCords == 'PA/Performing Arts Theatre'){
      latitudeClass1 =  34.6754613377245;
      longitudeClass1 = -118.18723230937766;
    }
    else if (classforCords == 'FA1/Art Gallery'){
      latitudeClass1 =  34.676203764577544;
      longitudeClass1 = -118.18697930907051;
    }
    else if (classforCords == 'FA2/Black Box'){
      latitudeClass1 =  34.675832701065104;
      longitudeClass1 = -118.18737862660834;
    }
    else if (classforCords == 'MH/Mesquite Hall'){
      latitudeClass1 =  34.67687342944362;
      longitudeClass1 = -118.18512883579885;
    }
    else if (classforCords == 'LH/Lecture Hall'){
      latitudeClass1 =  34.677011511466674;
      longitudeClass1 = -118.18741261041862;
    }
    else if (classforCords == 'SH/Sage Hall'){
      latitudeClass1 =  34.67714651488922;
      longitudeClass1 = -118.18709120662562;
    }
    else if (classforCords == 'ME/Math and Engineering'){
      latitudeClass1 =  34.67775573632852;
      longitudeClass1 = -118.18589961736947;
    }
    else if (classforCords == 'FA4/Fine Arts'){
      latitudeClass1 =  34.67648676160919;
      longitudeClass1 = -118.18738628333938;
    }
    else if (classforCords == 'FA3/Fine Arts Music and Offices'){
      latitudeClass1 =  34.67626532974614;
      longitudeClass1 = -118.18770778514867;
    }
    else if (classforCords == 'EL/Enterprise Lab'){
      latitudeClass1 =  34.67973186506707;
      longitudeClass1 = -118.18654794631942;
    }
    else if (classforCords == 'HL/Horticulture Lab'){
      latitudeClass1 =  34.679898891625314;
      longitudeClass1 = -118.1870825677824;
    }
    else if (classforCords == 'GH1-4/Greenhouses'){
      latitudeClass1 =  34.679813863502766;
      longitudeClass1 = -118.18775289064219;
    }
    else{
      latitudeClass1 =  34.678652329599096;
      longitudeClass1 = -118.18616290156892;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp(latitude: latitudeClass1, longitude: longitudeClass1, zoom: 19,)),
      );
  }


}
