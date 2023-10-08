import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:interactivemap/main.dart';
import 'package:interactivemap/src/class_1_creator.dart';
import 'package:interactivemap/src/class_2_creator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:day_picker/day_picker.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  _ClassPage createState() => _ClassPage();
}

class _ClassPage extends State<ClassPage>{

  @override
  void initState() {
    loadData();
    super.initState();
  }
  final List<DayInWeek> _days = [
    DayInWeek(
      "Mon", dayKey: 'Mon',
    ),
    DayInWeek(
      "Tue", dayKey: 'Tue',
    ),
    DayInWeek(
      "Wed", dayKey: 'Wed',
    ),
    DayInWeek(
      "Thur", dayKey: 'Thur',
    ),
    DayInWeek(
      "Fri", dayKey: 'Fri',
    ),
    DayInWeek(
      "Sat", dayKey: 'Sat',
    ),
    DayInWeek(
      "Sun", dayKey: 'Sun',
    ),
  ];

  Color textColor= Color.fromARGB(255, 141, 185, 202); // avc blue


  final Color avcorange = Color.fromARGB(255, 241, 138, 32); // avc orange
  final Color avcblue = Color.fromARGB(255, 141, 185, 202);// avc blue
  final Color avcgreen = Color.fromARGB(255, 0, 107, 103); // avc green

  double latitudeClass1 = 34.67613026710341;
  double longitudeClass1 = -118.19203306356845;

  List<String> classList = ['Select a class', 'CSUB/CSU Bakersfield', 'DL/Discovery Lab ', 'AL/Auto Lab', 'UH/Uhazy Hall', 'YH/Yoshida Hall', 'S1-9/SOAR High School', 'PA/Performing Arts Theatre', 'FA1/Art Gallery', 'FA2/Black Box', 'MH/Mesquite Hall', 'LH/Lecture Hall', 'SH/Sage Hall', 'ME/Math and Engineering', 'FA4/Fine Arts', 'FA3/Fine Arts Music and Offices', 'EL/Enterprise Lab', 'HL/Horticulture Lab', 'GH1-4/Greenhouses'];
  String? selectedItem = 'Select a class';


  TimeOfDay time = const TimeOfDay(hour: 1, minute: 00);
  TimeOfDay time2 = const TimeOfDay(hour: 1, minute: 00);

  late int classselect = 0;


  String panelValue = "";

  // to do: finish adding selectors for the rest of the classes

  late bool classdeletetog = false;
  late String timepart1 = "01";
  late String timepart2 = "00";

  late int classmanagecode = 0;   //used to select which class is picked when you press manage

  late String daypart1 = "";
  late String daypart2 = "";

  late int sendcodec1 = 0; //old?


  late int classsendcode = 0;

  late int showclasscode = 0;

  late int timesendcode = 0;

  late int class_go_pick = 0;

  late String classforCords = "";

  late bool showManage = false;

  late bool shownext2 = false;
  late bool shownext3 = false;
  late bool shownext4 = false;
  late bool shownext5 = false;
  late bool shownext6 = false;
  late bool shownext7 = false;

  late bool showclass1 = false;
  late bool showclass2 = false;
  late bool showclass3 = false;
  late bool showclass4 = false;
  late bool showclass5 = false;
  late bool showclass6 = false;
  late bool showclass7 = false;

  late int addclasssendcode = 0;

  late String buldingselect = "";

  late String class1Select = "";
  late String class2Select = "";
  late String class3Select = "";
  late String class4Select = "";
  late String class5Select = "";
  late String class6Select = "";
  late String class7Select = "";

  late String class1name = "";
  late String class2name = "";
  late String class3name = "";
  late String class4name = "";
  late String class5name = "";
  late String class6name = "";
  late String class7name = "";

  late String class1time = "";
  late String class2time = "";
  late String class3time = "";
  late String class4time = "";
  late String class5time = "";
  late String class6time = "";
  late String class7time = "";

  late String class1day = "";
  late String class2day = "";
  late String class3day = "";
  late String class4day = "";
  late String class5day = "";
  late String class6day = "";
  late String class7day = "";

  late String class1image = "";
  late String class2image = "";
  late String class3image = "";
  late String class4image = "";
  late String class5image = "";
  late String class6image = "";
  late String class7image = "";

  late String class1room = "";
  late String class2room = "";
  late String class3room = "";
  late String class4room = "";
  late String class5room = "";
  late String class6room = "";
  late String class7room = "";

  late Map<String, Object> data = {};

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      showclass1 = prefs.getBool('ShowClass1') ?? false;
      showclass2 = prefs.getBool('ShowClass2') ?? false;
      showclass3 = prefs.getBool('ShowClass3') ?? false;
      showclass4 = prefs.getBool('ShowClass4') ?? false;
      showclass5 = prefs.getBool('ShowClass5') ?? false;
      showclass6 = prefs.getBool('ShowClass6') ?? false;
      showclass7 = prefs.getBool('ShowClass7') ?? false;

      shownext2 = prefs.getBool('shownext2') ?? false;
      shownext3 = prefs.getBool('shownext3') ?? false;
      shownext4 = prefs.getBool('shownext4') ?? false;
      shownext5 = prefs.getBool('shownext5') ?? false;
      shownext6 = prefs.getBool('shownext6') ?? false;
      shownext7 = prefs.getBool('shownext7') ?? false;

      class1Select = prefs.getString('Class1Select') ?? '';
      class2Select = prefs.getString('Class2Select') ?? '';
      class3Select = prefs.getString('Class3Select') ?? '';
      class4Select = prefs.getString('Class4Select') ?? '';
      class5Select = prefs.getString('Class5Select') ?? '';
      class6Select = prefs.getString('Class6Select') ?? '';
      class7Select = prefs.getString('Class7Select') ?? '';

      class1name = prefs.getString('class1_Name') ?? '';
      class2name = prefs.getString('class2_Name') ?? '';
      class3name = prefs.getString('class3_Name') ?? '';
      class4name = prefs.getString('class4_Name') ?? '';
      class5name = prefs.getString('class5_Name') ?? '';
      class6name = prefs.getString('class6_Name') ?? '';
      class7name = prefs.getString('class7_Name') ?? '';

      class1time = prefs.getString('class1_Time') ?? '';
      class2time = prefs.getString('class2_Time') ?? '';
      class3time = prefs.getString('class3_Time') ?? '';
      class4time = prefs.getString('class4_Time') ?? '';
      class5time = prefs.getString('class5_Time') ?? '';
      class6time = prefs.getString('class6_Time') ?? '';
      class7time = prefs.getString('class7_Time') ?? '';

      class1day = prefs.getString('class1_Day') ?? '';
      class2day = prefs.getString('class2_Day') ?? '';
      class3day = prefs.getString('class3_Day') ?? '';
      class4day = prefs.getString('class4_Day') ?? '';
      class5day = prefs.getString('class5_Day') ?? '';
      class6day = prefs.getString('class6_Day') ?? '';
      class7day = prefs.getString('class7_Day') ?? '';

      class1room = prefs.getString('class1_Room') ?? '';
      class2room = prefs.getString('class2_Room') ?? '';
      class3room = prefs.getString('class3_Room') ?? '';
      class4room = prefs.getString('class4_Room') ?? '';
      class5room = prefs.getString('class5_Room') ?? '';
      class6room = prefs.getString('class6_Room') ?? '';
      class7room = prefs.getString('class7_Room') ?? '';

      class1image = prefs.getString('class1_image') ?? '';
      class2image = prefs.getString('class2_image') ?? '';
      class3image = prefs.getString('class3_image') ?? '';
      class4image = prefs.getString('class4_image') ?? '';
      class5image = prefs.getString('class5_image') ?? '';
      class6image = prefs.getString('class6_image') ?? '';
      class7image = prefs.getString('class7_image') ?? '';
      
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

           // start class 1 ----------------------------------------------------
           showclass1 ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 3,
                  color: Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF8B1C3F)
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        FadeInImage(image: NetworkImage(class1image),
                          placeholder: const AssetImage('assets/images/here_you_go_bblake.png'),
                          imageErrorBuilder: (c, o, s) => Image.asset(
                              'assets/images/image_avc_logo.png',
                            height: 100,
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Text(class1Select,
                          style: const TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color.fromARGB(255, 141, 185, 202),
                        ),

                        Row(
                          children: [
                            Text("       Class: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class1name,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Room: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class1room,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Time: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class1time,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Day: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: avcblue
                              ),
                            ),
                            Text(class1day,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          title: const Text('Manage Class',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              )
                          ),
                          onTap: () {
                            setState(() {
                              classmanagecode = 1;
                            });
                            _showSlideUpPanelclass1(context);
                          },
                        ),
                      ],
                    ), //),
                  )
                ],
              ),
            ) :const SizedBox(),
           showclass1 ? ElevatedButton(
             onPressed: (){
               class_go_pick = 1;
               goPress();
             },
             style:ButtonStyle(
               backgroundColor:  MaterialStatePropertyAll(
                 avcgreen,
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
           ): const SizedBox(),
            showclass1 ? const SizedBox():
            ElevatedButton(
              onPressed: (){
                shownext2 = true;
                showclass1 = true;
                classaddbutton();
              },
              style:ButtonStyle(
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
                'Add a class',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            //end class 1 ------------------------------------------------------

            const Divider(thickness: 5, color: Colors.transparent,),
            const Divider(thickness: 5, color: Colors.transparent,),
            const Divider(thickness: 5, color: Colors.transparent,),

            //start class 2 -----------------------------------------------------
          showclass2 ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 3,
                color: Colors.transparent,
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF8B1C3F)
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      FadeInImage(image: NetworkImage(class2image),
                        placeholder: AssetImage('assets/images/here_you_go_bblake.png'),
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          'assets/images/image_avc_logo.png',
                          height: 100,
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      Text(class2Select,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Color.fromARGB(255, 141, 185, 202),
                      ),

                      Row(
                        children: [
                          Text("       Class: ",
                            style: TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                                color: textColor
                            ),
                          ),
                          Text(class2name,
                            style: const TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("       Room: ",
                            style: TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                                color: textColor
                            ),
                          ),
                          Text(class2room,
                            style: const TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("       Time: ",
                            style: TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                                color: textColor
                            ),
                          ),
                          Text(class2time,
                            style: const TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("       Day: ",
                            style: TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                                color: textColor
                            ),
                          ),
                          Text(class2day,
                            style: const TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: const Text('Manage Class',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        onTap: () {
                          setState(() {
                            classmanagecode = 2;
                          });
                          _showSlideUpPanelclass1(context);
                        },
                      ),
                    ],
                  ), //),
                )
              ],
            ),
          ) :const SizedBox(),
            showclass2 ? ElevatedButton(
              onPressed: (){
                class_go_pick = 2;
                goPress();
              },
              style:ButtonStyle(
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
            ): const SizedBox(),
            showclass2 ? const SizedBox():
                Visibility(
                  visible: shownext2,
                  child: ElevatedButton(
                  onPressed: (){
                    shownext3 = true;
                    showclass2 = true;
                    classaddbutton();
                  },
                  style:ButtonStyle(
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
                    'Add a class',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                ),

            //end class 2 ------------------------------------------------------

            const Divider(thickness: 5, color: Colors.transparent,),
            const Divider(thickness: 5, color: Colors.transparent,),
            const Divider(thickness: 5, color: Colors.transparent,),
            
          //start class 3 --------------------------------------------------------
          showclass3 ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 3,
                  color: Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF8B1C3F)
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        FadeInImage(image: NetworkImage(class3image),
                          placeholder: const AssetImage('assets/images/here_you_go_bblake.png'),
                          imageErrorBuilder: (c, o, s) => Image.asset(
                              'assets/images/image_avc_logo.png',
                            height: 100,
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Text(class3Select,
                          style: const TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color.fromARGB(255, 141, 185, 202),
                        ),

                        Row(
                          children: [
                            Text("       Class: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class3name,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Room: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class3room,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Time: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class3time,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Day: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: avcblue
                              ),
                            ),
                            Text(class3day,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          title: const Text('Manage Class',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              )
                          ),
                          onTap: () {
                            setState(() {
                              classmanagecode = 3;
                            });
                            _showSlideUpPanelclass1(context);
                          },
                        ),
                      ],
                    ), //),
                  )
                ],
              ),
            ) :const SizedBox(),
           showclass3 ? ElevatedButton(
             onPressed: (){
               class_go_pick = 1;
               goPress();
             },
             style:ButtonStyle(
               backgroundColor:  MaterialStatePropertyAll(
                 avcgreen,
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
           ): const SizedBox(),
            showclass3 ? const SizedBox():
                Visibility(
                  visible: shownext3,
                  child: ElevatedButton(
                  onPressed: (){
                    shownext4 = true;
                    showclass3 = true;
                    classaddbutton();
                  },
                  style:ButtonStyle(
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
                    'Add a class',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      ),
                    ),
                  ),
                ),


            const Divider(thickness: 5, color: Colors.transparent,),
            const Divider(thickness: 5, color: Colors.transparent,),
            const Divider(thickness: 5, color: Colors.transparent,),

            //start class 4 --------------------------------------------------------
          showclass4 ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 3,
                  color: Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF8B1C3F)
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        FadeInImage(image: NetworkImage(class4image),
                          placeholder: const AssetImage('assets/images/here_you_go_bblake.png'),
                          imageErrorBuilder: (c, o, s) => Image.asset(
                              'assets/images/image_avc_logo.png',
                            height: 100,
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Text(class4Select,
                          style: const TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color.fromARGB(255, 141, 185, 202),
                        ),

                        Row(
                          children: [
                            Text("       Class: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class4name,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Room: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class4room,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Time: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                            Text(class4time,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("       Day: ",
                              style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.bold,
                                  color: avcblue
                              ),
                            ),
                            Text(class4day,
                              style: const TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          title: const Text('Manage Class',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              )
                          ),
                          onTap: () {
                            setState(() {
                              classmanagecode = 4;
                            });
                            _showSlideUpPanelclass1(context);
                          },
                        ),
                      ],
                    ), //),
                  )
                ],
              ),
            ) :const SizedBox(),
           showclass4 ? ElevatedButton(
             onPressed: (){
               class_go_pick = 1;
               goPress();
             },
             style:ButtonStyle(
               backgroundColor:  MaterialStatePropertyAll(
                 avcgreen,
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
           ): const SizedBox(),
            showclass4 ? const SizedBox():
                Visibility(
                  visible: shownext4,
                  child: ElevatedButton(
                  onPressed: (){
                    shownext5 = true;
                    showclass4 = true;
                    classaddbutton();
                  },
                  style:ButtonStyle(
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
                    'Add a class',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  ),
                ),

            const Divider(thickness: 5, color: Colors.transparent,),
            const Divider(thickness: 5, color: Colors.transparent,),
            const Divider(thickness: 5, color: Colors.transparent,),


          ],
        ),
      ),
    );
  }

  void _showSlideUpPanelclass1(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: MediaQuery.of(context).size.height * 0.87, // Set maximum height,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    "Class Information"
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.transparent,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select a building',
                    ),
                    items:classList.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                    onChanged: (val) {
                      setState((){
                        selectedItem = val as String;
                        buldingselect = val as String;
                        if(classmanagecode == 1){
                          class1Select = val as String;
                          classsendcode = 1;
                        }
                        else if(classmanagecode == 2){
                          class2Select = val as String;
                          classsendcode = 2;
                        }
                        else if(classmanagecode == 3){
                          class3Select = val as String;
                          classsendcode = 3;
                        }
                        else if(classmanagecode == 4){
                          class4Select = val as String;
                          classsendcode = 4;
                        }
                        else if(classmanagecode == 5){
                          class5Select = val as String;
                          classsendcode = 5;
                        }
                        else if(classmanagecode == 6){
                          class6Select = val as String;
                          classsendcode = 6;
                        }
                        else if(classmanagecode == 7){
                          class7Select = val as String;
                          classsendcode = 7;
                        }
                        
                      });
                    },
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name of class e.g. Bio 101',
                    ),
                    onChanged: (val) {
                      setState((){
                        if(classmanagecode == 1){
                          class1name = val as String;
                        }
                        else if(classmanagecode == 2){
                          class2name = val as String;
                        }
                        else if(classmanagecode == 3){
                          class3name = val as String;
                        }
                        else if(classmanagecode == 4){
                          class4name = val as String;
                        }
                        else if(classmanagecode == 5){
                          class5name = val as String;
                        }
                        else if(classmanagecode == 6){
                          class6name = val as String;
                        }
                        else if(classmanagecode == 7){
                          class7name = val as String;
                        }
                        
                      });
                    },
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Room number e.g. 105',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState((){
                        if(classmanagecode == 1){
                          class1room = val as String;
                        }
                        else if(classmanagecode == 2){
                          class2room = val as String;
                        }
                        else if(classmanagecode == 3){
                          class3room = val as String;
                        }
                        else if(classmanagecode == 4){
                          class4room = val as String;
                        }
                        else if(classmanagecode == 5){
                          class5room = val as String;
                        }
                        else if(classmanagecode == 6){
                          class6room = val as String;
                        }
                        else if(classmanagecode == 7){
                          class7room = val as String;
                        }
                      });
                    },
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  const Text(
                    'Time: ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [avcgreen, avcgreen],
                            tileMode:
                            TileMode.repeated, 
                          ),
                        ),
                        child: ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: time);
                          if(newTime == null){
                            return;
                          }
                          setState(() {
                            time = newTime;
                            if(classmanagecode == 1){
                              timesendcode = 1;
                            }
                            else if(classmanagecode == 2){
                              timesendcode = 2;
                            }
                            else if(classmanagecode == 3){
                              timesendcode = 3;
                            }
                            else if(classmanagecode == 4){
                              timesendcode = 4;
                            }
                            else if(classmanagecode == 5){
                              timesendcode = 5;
                            }
                            else if(classmanagecode == 6){
                              timesendcode = 6;
                            }
                            else if(classmanagecode == 7){
                              timesendcode = 7;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent
                            ),
                        child: Text(
                          time.format(context) ?? 'Select start time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ),
                      const SizedBox(width: 10),

                      const Text(
                            'TO',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        
                      const SizedBox(width: 10),


                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [avcgreen, avcgreen],
                            tileMode:
                            TileMode.repeated, 
                          ),
                        ),
                        child: ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: time2);
                          if(newTime == null){
                            return;
                          }
                          setState(() {
                            if(classmanagecode == 1){
                              timesendcode = 1;
                            }
                            else if(classmanagecode == 2){
                              timesendcode = 2;
                            }
                            else if(classmanagecode == 3){
                              timesendcode = 3;
                            }
                            else if(classmanagecode == 4){
                              timesendcode = 4;
                            }
                            else if(classmanagecode == 5){
                              timesendcode = 5;
                            }
                            else if(classmanagecode == 6){
                              timesendcode = 6;
                            }
                            else if(classmanagecode == 7){
                              timesendcode = 7;
                            }
                            time2 = newTime;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent
                            ),
                        child: Text(
                          time2.format(context) ?? 'Select end time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ), 
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  const Text(
                    'Day: ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.transparent,
                  ),
                  SelectWeekDays(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    days: _days,
                    border: false,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [avcgreen, avcgreen],
                        tileMode:
                        TileMode.repeated, 
                      ),
                    ),
                    onSelect: (values) {
                      print(values);
                        if(classmanagecode == 1){
                          class1day = values.toString();
                          class1day = class1day.substring(1, class1day.length - 1);
                        }
                        else if(classmanagecode == 2){
                          class2day = values.toString();
                          class2day = class2day.substring(1, class2day.length - 1);
                        }
                        else if(classmanagecode == 3){
                          class3day = values.toString();
                          class3day = class3day.substring(1, class3day.length - 1);
                        }
                        else if(classmanagecode == 4){
                          class4day = values.toString();
                          class4day = class4day.substring(1, class4day.length - 1);
                        }
                        else if(classmanagecode == 5){
                          class5day = values.toString();
                          class5day = class5day.substring(1, class5day.length - 1);
                        }
                        else if(classmanagecode == 6){
                          class6day = values.toString();
                          class6day = class6day.substring(1, class6day.length - 1);
                        }
                        else if(classmanagecode == 7){
                          class7day = values.toString();
                          class7day = class7day.substring(1, class7day.length - 1);
                        }
                    },
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.transparent,
                  ),
                  const Divider(
                    thickness: 5,
                    color: Colors.transparent,
                  ),
                  const Divider(
                    thickness: 3,
                  ),
//---------------------------------------------------------------------------------------------------------------------------------------------------------
                  ElevatedButton(
                    onPressed: (){
                      saveData();
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
                      'Save Class',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(classmanagecode == 1){
                          showclasscode = 1;
                        }
                        else if(classmanagecode == 2){
                          showclasscode = 2;
                        }
                        else if(classmanagecode == 3){
                          showclasscode = 3;
                        }
                        else if(classmanagecode == 4){
                          showclasscode = 4;
                        }
                        else if(classmanagecode == 5){
                          showclasscode = 5;
                        }
                        else if(classmanagecode == 6){
                          showclasscode = 6;
                        }
                        else if(classmanagecode == 7){
                          showclasscode = 7;
                        }
                      classremovebutton();
                    },
                    style:  ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff8d1c40),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Remove Class',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  
  
  
  void saveData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String selectedimg = '';

    if (buldingselect == 'CSUB/CSU Bakersfield'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_bakersfield.jpg?raw=true';
    }
    else if (buldingselect == 'DL/Discovery Lab'){
      selectedimg = '';
    }
    else if (buldingselect == 'AL/Auto Lab'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_autolab.jpg?raw=true';
    }
    else if (buldingselect == 'UH/Uhazy Hall'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_uhazyhall.jpg?raw=true';
    }
    else if (buldingselect == 'YH/Yoshida Hall'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_yoshidahall.jpg?raw=true';
    }
    else if (buldingselect == 'S1-9/SOAR High School'){
      selectedimg = '';
    }
    else if (buldingselect == 'PA/Performing Arts Theatre'){
      selectedimg = '';
    }
    else if (buldingselect == 'FA1/Art Gallery'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_artgallery.jpg?raw=true';
    }
    else if (buldingselect == 'FA2/Black Box'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_blackbox.jpg?raw=true';
    }
    else if (buldingselect == 'MH/Mesquite Hall'){

      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_mh.jpg?raw=true';
    }
    else if (buldingselect == 'LH/Lecture Hall'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_lh.jpg?raw=true';
    }
    else if (buldingselect == 'SH/Sage Hall'){
      selectedimg = "https://www.avc.edu/sites/default/files/inline-images/nov2021-1.png?raw=true";
    }
    else if (buldingselect == 'ME/Math and Engineering'){
      selectedimg= 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_me.jpg?raw=true';
    }
    else if (buldingselect == 'FA4/Fine Arts'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_finearts.jpg?raw=true';
    }
    else if (buldingselect == 'FA3/Fine Arts Music and Offices'){
      String selectedimg = '';
    }
    else if (buldingselect == 'EL/Enterprise Lab'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_enterpriselab.jpg?raw=true';
    }
    else if (buldingselect == 'HL/Horticulture Lab'){
      selectedimg= 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_horticulture.jpg?raw=true';
    }
    else if (buldingselect == 'GH1-4/Greenhouses'){
      selectedimg = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_greenhouse.jpg?raw=true';
    }

    if(classsendcode == 1){
      class1image = selectedimg;
    }
    else if (classsendcode == 2){
      class2image = selectedimg;
    }
    else if (classsendcode == 3){
      class3image = selectedimg;
    }
    else if (classsendcode == 4){
      class4image = selectedimg;
    }
    else if (classsendcode == 5){
      class5image = selectedimg;
    }
    else if (classsendcode == 6){
      class6image = selectedimg;
    }
    else if (classsendcode == 7){
      class7image = selectedimg;
    }

    if(timesendcode == 1){
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class1time = "$timepart1 - $timepart2";
    }
    else if (timesendcode == 2){
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class2time = "$timepart1 - $timepart2";
    }
    else if (timesendcode == 3){
    }
    else if (timesendcode == 4){
    }
    else if (timesendcode == 5){
    }
    else if (timesendcode == 6){
    }
    else if (timesendcode == 7){
    }

    setState(() {
      prefs.setString('Class1Select', class1Select);
      prefs.setString('Class2Select', class2Select);
      prefs.setString('Class3Select', class3Select);
      prefs.setString('Class4Select', class4Select);
      prefs.setString('Class5Select', class5Select);
      prefs.setString('Class6select', class6Select);
      prefs.setString('Class7Select', class7Select);

      prefs.setString('class1_Name', class1name);
      prefs.setString('class2_Name', class2name);
      prefs.setString('class3_Name', class3name);
      prefs.setString('class4_Name', class4name);
      prefs.setString('class5_Name', class5name);
      prefs.setString('class6_Name', class6name);
      prefs.setString('class7_Name', class7name);

      prefs.setString('class1_Time', class1time);
      prefs.setString('class2_Time', class2time);
      prefs.setString('class3_Time', class3time);
      prefs.setString('class4_Time', class4time);
      prefs.setString('class5_Time', class5time);
      prefs.setString('class6_Time', class6time);
      prefs.setString('class7_Time', class7time);

      prefs.setString('class1_Day', class1day);
      prefs.setString('class2_Day', class2day);
      prefs.setString('class3_Day', class3day);
      prefs.setString('class4_Day', class4day);
      prefs.setString('class5_Day', class5day);
      prefs.setString('class6_Day', class6day);
      prefs.setString('class7_Day', class7day);

      prefs.setString('class1_image', class1image);
      prefs.setString('class2_image', class2image);
      prefs.setString('class3_image', class3image);
      prefs.setString('class4_image', class4image);
      prefs.setString('class5_image', class5image);
      prefs.setString('class6_image', class6image);
      prefs.setString('class7_image', class7image);
      

      prefs.setString('class1_Room', class1room);
      prefs.setString('class2_Room', class2room);
      prefs.setString('class3_Room', class3room);
      prefs.setString('class4_Room', class4room);
      prefs.setString('class5_Room', class5room);
      prefs.setString('class6_Room', class6room);
      prefs.setString('class7_Room', class7room);
    });
  }

  void clearData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    classdeletetog = true;
    setState(() {
      prefs.clear();
      prefs.setBool('ShowClass1', false);
    });
  }


  void classaddbutton() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(addclasssendcode == 1){
      showclass1 = true;
    }
    else if (addclasssendcode == 2){
      showclass2 = true;
    }
    else if (addclasssendcode == 3){
      showclass3 = true;
    }
    else if (addclasssendcode == 4){
      showclass4 = true;
    }
    else if (addclasssendcode == 5){
      showclass5 = true;
    }
    else if (addclasssendcode == 6){
      showclass6 = true;
    }
    else if (addclasssendcode == 7){
      showclass7 = true;
    }
    setState(() {
      prefs.setBool('shownext2', shownext2);
      prefs.setBool('shownext3', shownext3);
      prefs.setBool('shownext4', shownext4);
      prefs.setBool('shownext5', shownext5);
      prefs.setBool('shownext6', shownext6);
      prefs.setBool('shownext7', shownext7);

      prefs.setBool('ShowClass1', showclass1);
      prefs.setBool('ShowClass2', showclass2);
      prefs.setBool('ShowClass3', showclass3);
      prefs.setBool('ShowClass4', showclass4);
      prefs.setBool('ShowClass5', showclass5);
      prefs.setBool('ShowClass6', showclass6);
      prefs.setBool('ShowClass7', showclass7);
    });
  }
  void classremovebutton() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //prefs.clear();
      if(showclasscode == 1){
        prefs.setBool('ShowClass1', false);
        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (showclasscode == 2){
        prefs.setBool('ShowClass2', false);

        prefs.setBool('shownext2', true);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (showclasscode == 3){
        prefs.setBool('ShowClass3', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', true);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (showclasscode == 4){
        prefs.setBool('ShowClass4', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', true);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (showclasscode == 5){
        prefs.setBool('ShowClass5', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', true);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (showclasscode == 6){
        prefs.setBool('ShowClass6', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', true);
        prefs.setBool('shownext7', false);
      }
      else if (showclasscode == 7){
        prefs.setBool('ShowClass7', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', true);
      }
    });
  }
  void goPress() async{
    if (class_go_pick == 1){
      classforCords = class1Select;
    }
    else if(class_go_pick == 2){
      classforCords = class2Select;
    }
    else if(class_go_pick == 3){
      classforCords = class3Select;
    }
    else if(class_go_pick == 4){
      classforCords = class4Select;
    }
    else if(class_go_pick == 5){
      classforCords = class5Select;
    }
    else if(class_go_pick == 6){
      classforCords = class6Select;
    }

    if (classforCords == 'CSUB/CSU Bakersfield'){
      latitudeClass1 =  34.680353586506165;
      longitudeClass1 = -118.18506976951421;
    }
    else if (classforCords == 'DL/Discovery Lab'){
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
