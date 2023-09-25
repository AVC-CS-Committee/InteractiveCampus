import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interactivemap/src/aboutus_page.dart';
import 'package:interactivemap/src/emergency_page.dart';
import 'package:interactivemap/src/faq_page.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:interactivemap/src/faq_page.dart';

// import 'package:google_maps_routes/google_maps_routes.dart';


class ClassCreator extends StatefulWidget {
  @override
  _ClassCreator createState() => _ClassCreator();
}

class _ClassCreator extends State<ClassCreator> {


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

  @override
  void initState() {
    loadData();
    super.initState();
  }

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

   //const ClassPage({Key? key}) : super(key: key);
  List<String> classList = ['Select a class', 'YH/Yoshida Hal', 'UH/Uhazy Hall', 'Four'];
  String? selectedItem = 'Select a class';

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
           const Text('Please Enter your Classes here!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
//---------------------------------------------------------------------------------------------------------------------------------------------------------
            const Divider(),
            const Text("Class 1",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
            DropdownButton(
              value: selectedItem,
              items: classList.map((e) => DropdownMenuItem(child: Text(e), value: e,)).toList(),
              onChanged: (val) {
                setState((){
                  selectedItem = val as String;
                  class1Select = val as String;
                });
              },
             ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Class Name',
              ),
              onChanged: (val) {
                setState((){
                  class1_Name = val as String;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Class Time',
              ),
              onChanged: (val) {
                setState((){
                  class1_Time = val as String;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Class Day',
              ),
              onChanged: (val) {
                setState((){
                  class1_Day = val as String;
                });
              },
            ),
//---------------------------------------------------------------------------------------------------------------------------------------------------------

            OutlinedButton(
              onPressed: saveData, 
              child: const Text("Save Classes"),
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
              ), 
            ),
            OutlinedButton(
              onPressed: clearData, 
              child: const Text("Clear Classes"),
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
              ), 
            ),
          ],
        ),
      ),
    );
  }



    void saveData() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString('Class1Select', class1Select);
        prefs.setString('class1_Name', class1_Name);
        prefs.setString('class1_Time', class1_Time);
        prefs.setString('class1_Day', class1_Day);
      });
    }

    void clearData() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
      prefs.setString('Class1Select' , '');
      prefs.setString('Class2Select' , '');
      prefs.setString('Class3Select' , '');
      prefs.setString('Class4Select' , '');
      prefs.setString('Class5Select' , '');

      prefs.setString('class1_Name', '');

      prefs.setString('class1_Day', '');

      prefs.setString('class1_Time', '');
      });
    }


}
