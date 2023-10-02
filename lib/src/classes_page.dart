import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:interactivemap/main.dart';
import 'package:interactivemap/src/class_1_creator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  _ClassPage createState() => _ClassPage();
}

class _ClassPage extends State<ClassPage> {

  @override
  void initState() {
    loadData();
    super.initState();
  }


  Color textColor = Color.fromARGB(255, 241, 138, 32); // avc orange
  //Color textColor = Color.fromARGB(255, 141, 185, 202);// avc blue
 //Color textColor = Color.fromARGB(255, 0, 107, 103); // avc green

  double latitudeClass1 = 34.67613026710341;
  double longitudeClass1 = -118.19203306356845;

  late int class1pick = 0;

  late String classforCords = "";


  late String class1Select = "Select a class";
  late String class2Select = "Select a class";
  late String class3Select = "Select a class";
  late String class4Select = "Select a class";
  late String class5Select = "Select a class";
  late String class6Select = "Select a class";


  late String class1name = "class name";
  late String class2name = "class name";
  late String class3name = "class name";
  late String class4name = "class name";
  late String class5name = "class name";
  late String class6name = "class name";


  late String class1time = "Class Time";
  late String class2time = "Class Time";
  late String class3time = "Class Time";
  late String class4time = "Class Time";
  late String class5time = "Class Time";
  late String class6time = "Class Time";


  late String class1day = "Class Day";
  late String class2day = "Class Day";
  late String class3day = "Class Day";
  late String class4day = "Class Day";
  late String class5day = "Class Day";
  late String class6day = "";

  late String class1image = "" ;
  late String class2image = "" ;
  late String class3image = "" ;
  late String class4image = "" ;
  late String class5image = "" ;
  late String class6image = "" ;

  late String class1room = "";
  late String class2room = "";
  late String class3room = "";
  late String class4room = "";
  late String class5room = "";
  late String class6room = "";


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

      class1name = prefs.getString('class1_Name') ?? '';
      class2name = prefs.getString('class2_Name') ?? '';
      class3name = prefs.getString('class3_Name') ?? '';
      class4name = prefs.getString('class4_Name') ?? '';
      class5name = prefs.getString('class5_Name') ?? '';
      class6name = prefs.getString('class6_Name') ?? '';

      class1time = prefs.getString('class1_Time') ?? '';
      class2time = prefs.getString('class2_Time') ?? '';
      class3time = prefs.getString('class3_Time') ?? '';
      class4time = prefs.getString('class4_Time') ?? '';
      class5time = prefs.getString('class5_Time') ?? '';
      class6time = prefs.getString('class6_Time') ?? '';

      class1day = prefs.getString('class1_Day') ?? '';
      class2day = prefs.getString('class2_Day') ?? '';
      class3day = prefs.getString('class3_Day') ?? '';
      class4day = prefs.getString('class4_Day') ?? '';
      class5day = prefs.getString('class5_Day') ?? '';
      class6day = prefs.getString('class6_Day') ?? '';

      class1room = prefs.getString('class1_Room') ?? '';
      class2room = prefs.getString('class2_Room') ?? '';
      class3room = prefs.getString('class3_Room') ?? '';
      class4room = prefs.getString('class4_Room') ?? '';
      class5room = prefs.getString('class5_Room') ?? '';
      class6room = prefs.getString('class6_Room') ?? '';

      class1image = prefs.getString('class1_image') ?? '';
      class2image = prefs.getString('class2_image') ?? '';
      class3image = prefs.getString('class3_image') ?? '';
      class4image = prefs.getString('class4_image') ?? '';
      class5image = prefs.getString('class5_image') ?? '';
      class6image = prefs.getString('class6_image') ?? '';
      
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
          padding: const EdgeInsets.all(30),
          children:<Widget> [
          const Text('Class Schedule',
             textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 241, 138, 32)
              ),
            ),
          const Divider(
            thickness: 3,
            color: Colors.black,
          ),
          const Divider(
            thickness: 3,
            color: Colors.transparent,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF8B1C3F)
            ),
            height: 420,
            width: 100,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image(image: NetworkImage(class1image),
                  alignment: Alignment.topCenter,
                ),
                Text(class1Select,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Color.fromARGB(255, 141, 185, 202),
                ),
                Row(
                  children: [
                    Text("  Class: ",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: textColor
                      ),
                    ),
                    Text(class1name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("  Room: ",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: textColor
                      ),
                    ),
                    Text(class1room,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("  Time: ",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: textColor
                      ),
                    ),
                    Text(class1time,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("  Day: ",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: textColor
                      ),
                    ),
                    Text(class1day,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: const Text('Manage',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      )
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Class1creator()),
                    );
                  },
                ),
              ],
            ),
          ),
            const Divider(),
            ElevatedButton(
              onPressed: (){
                goPress();
              },
              style:  ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color(0xff006b67),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.transparent),
                      ),
                  ),
              ),
              child: const Text(
                'GO',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
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
                  MaterialPageRoute(builder: (context) => Class1creator()),
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
