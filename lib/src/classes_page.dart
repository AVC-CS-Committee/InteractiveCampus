import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interactivemap/src/aboutus_page.dart';
import 'package:interactivemap/main.dart';
import 'package:interactivemap/src/emergency_page.dart';
import 'package:interactivemap/src/faq_page.dart';
import 'package:interactivemap/src/faq_page.dart';
import 'package:interactivemap/src/Class_Route.dart';
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

  late String class1Select = "Select a class";
  late String class2Select = "Select a class";
  late String class3Select = "Select a class";
  late String class4Select = "Select a class";
  late String class5Select = "Select a class";

  late String class1_Name = "class name";
  late String class2_Name = "class name";
  late String class3_Name = "class name";
  late String class4_Name = "class name";
  late String class5_Name = "class name";

  late String class1_Time = "Class Time";
  late String class2_Time = "Class Time";
  late String class3_Time = "Class Time";
  late String class4_Time = "Class Time";
  late String class5_Time = "Class Time";

  late String class1_Day = "Class Day";
  late String class2_Day = "Class Day";
  late String class3_Day = "Class Day";
  late String class4_Day = "Class Day";
  late String class5_Day = "Class Day";

  late Map<String, Object> data = {};


  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    setState(() {
      class1Select = prefs.getString('Class1Select') ?? 'Select a class';
      class2Select = prefs.getString('Class2Select') ?? 'Select a class';
      class3Select = prefs.getString('Class3Select') ?? 'Select a class';
      class4Select = prefs.getString('Class4Select') ?? 'Select a class';
      class5Select = prefs.getString('Class5Select') ?? 'Select a class';

      class1_Name = prefs.getString('class1_Name') ?? 'Enter Class Name';
      class2_Name = prefs.getString('class2_Name') ?? 'Enter Class Name';
      class3_Name = prefs.getString('class3_Name') ?? 'Enter Class Name';
      class4_Name = prefs.getString('class4_Name') ?? 'Enter Class Name';
      class5_Name = prefs.getString('class5_Name') ?? 'Enter Class Name';

      class1_Time = prefs.getString('class1_Time') ?? 'Enter Class Time';

      class1_Day = prefs.getString('class1_Day') ?? 'Enter Class Day';
      
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
              onPressed: goPress,
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

    if (class1Select == 'YH/Yoshida Hall'){
      latitudeClass1 =  34.680353586506165;
      longitudeClass1 = -118.18506976951421;
    }
    else if (class1Select == 'UH/Uhazy Hall'){
      latitudeClass1 =  34.680353586506165;
      longitudeClass1 = -118.18506976951421;
    }
    else if (class1Select == '1'){
      latitudeClass1 =  34.680353586506165;
      longitudeClass1 = -118.18506976951421;
    }
    else if (class1Select == '2'){
      latitudeClass1 =  34.680353586506165;
      longitudeClass1 = -118.18506976951421;
    }
    else if (class1Select == '3'){
      latitudeClass1 =  34.680353586506165;
      longitudeClass1 = -118.18506976951421;
    }
    else if (class1Select == '4'){
      latitudeClass1 =  34.680353586506165;
      longitudeClass1 = -118.18506976951421;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp(latitude: latitudeClass1, longitude: longitudeClass1,)),
      );
  }

}
