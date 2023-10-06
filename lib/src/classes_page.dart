import 'dart:convert';
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

class _ClassPage extends State<ClassPage> {

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

  Color textColor = Color.fromARGB(255, 241, 138, 32); // avc orange
  //Color textColor = Color.fromARGB(255, 141, 185, 202);// avc blue
 //Color textColor = Color.fromARGB(255, 0, 107, 103); // avc green

  double latitudeClass1 = 34.67613026710341;
  double longitudeClass1 = -118.19203306356845;

  List<String> classList = ['Select a class', 'CSUB/CSU Bakersfield', 'DL/Discovery Lab ', 'AL/Auto Lab', 'UH/Uhazy Hall', 'YH/Yoshida Hall', 'S1-9/SOAR High School', 'PA/Performing Arts Theatre', 'FA1/Art Gallery', 'FA2/Black Box', 'MH/Mesquite Hall', 'LH/Lecture Hall', 'SH/Sage Hall', 'ME/Math and Engineering', 'FA4/Fine Arts', 'FA3/Fine Arts Music and Offices', 'EL/Enterprise Lab', 'HL/Horticulture Lab', 'GH1-4/Greenhouses'];
  String? selectedItem = 'Select a class';

  Color togcolor = Color.fromARGB(255, 241, 138, 32);
  Color togcolor2 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor3 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor4 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor5 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor6 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor7 = Color.fromARGB(255, 241, 138, 32);

  TimeOfDay time = const TimeOfDay(hour: 1, minute: 00);
  TimeOfDay time2 = const TimeOfDay(hour: 1, minute: 00);

  late int classselect = 0;


  String panelValue = "";

  // to do: finish adding selectors for the rest of the classes

  late bool classdeletetog = false;
  late String timepart1 = "01";
  late String timepart2 = "00";
  // late String timepart3 = "1";
  // late String timepart4 = "00";
  // late String timepart5 = "p.m.";


  late String daypart1 = class1day;
  late String daypart2 = "";
  late String daypart3 = "";
  late String daypart4 = "";
  late String daypart5 = "";
  late String daypart6 = "";
  late String daypart7 = "";

  // late bool montog = false;
  // late bool tuetog = false;
  // late bool wedtog = false;
  // late bool thurtog = false;
  // late bool fritog = false;
  // late bool sattog = false;
  // late bool suntog = false;

  late int sendcodec1 = 0;
  late int sendcodec2 = 0;
  late int sendcodec3 = 0;
  late int sendcodec4 = 0;
  late int sendcodec5 = 0;
  late int sendcodec6 = 0;
  late int sendcodec7 = 0;

  late int classsendcode = 0;

  late int showclasscode = 0;


  late int timesendcode = 0;



  late int class_go_pick = 0;

  late String classforCords = "";

  late bool showManage = false;

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


  late String class1name = "";
  late String class2name = "";
  late String class3name = "";
  late String class4name = "";
  late String class5name = "";
  late String class6name = "";


  late String class1time = "";
  late String class2time = "";
  late String class3time = "";
  late String class4time = "";
  late String class5time = "";
  late String class6time = "";


  late String class1day = "";
  late String class2day = "";
  late String class3day = "";
  late String class4day = "";
  late String class5day = "";
  late String class6day = "";

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
                          placeholder: AssetImage('assets/images/here_you_go_bblake.png'),
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
                                  color: textColor
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
            showclass1 ? const SizedBox():
            ElevatedButton(
              onPressed: (){
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
                          _showSlideUpPanelclass2(context);
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
            ElevatedButton(
              onPressed: (){
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
            //end class 2 ------------------------------------------------------

            // ListTile(
            //   title: const Text('Create a class Schedule',
            //   textAlign: TextAlign.center,
            //     style: TextStyle(
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Class1creator()),
            //     );
            //   },
            // ),

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
            return Container(
              height: MediaQuery.of(context).size.height * 0.85, // Set maximum height,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (newValue) {
                      setState(() {
                        panelValue = newValue; // Update the state
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Class Info'),
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
                        class1Select = val as String;
                        classsendcode = 1;
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
                        class1name = val as String;
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
                        class1room = val as String;
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
                      ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: time);
                          if(newTime == null){
                            return;
                          }
                          setState(() {
                            time = newTime;
                            timesendcode = 1;
                          });
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
                        child: Text(
                          time.format(context) ?? 'Select start time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: time2);
                          if(newTime == null){
                            return;
                          }
                          setState(() {
                            time2 = newTime;
                            timesendcode = 1;
                          });
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
                        child: Text(
                          time2.format(context) ?? 'Select end time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
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
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)],
                        tileMode:
                        TileMode.repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    onSelect: (values) { // <== Callback to handle the selected days
                      print(values);
                      class1day = values.toString();
                      class1day = class1day.substring(1, class1day.length - 1);
                      sendcodec1 = 1;
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
                      showclasscode = 1;
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
  void _showSlideUpPanelclass2(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85, // Set maximum height,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (newValue) {
                      setState(() {
                        panelValue = newValue; // Update the state
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Class Info'),
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
                        class2Select = val as String;
                        classsendcode = 2;
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
                        class2name = val as String;
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
                        class2room = val as String;
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
                      ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: time);
                          if(newTime == null){
                            return;
                          }
                          setState(() {
                            time = newTime;
                            timesendcode = 2;
                          });
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
                        child: Text(
                          time.format(context) ?? 'Select start time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: time2);
                          if(newTime == null){
                            return;
                          }
                          setState(() {
                            time2 = newTime;
                            timesendcode = 2;
                          });
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
                        child: Text(
                          time2.format(context) ?? 'Select end time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
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
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)],
                        tileMode:
                        TileMode.repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    onSelect: (values) { // <== Callback to handle the selected days
                      print(values);
                      class2day = values.toString();
                      class2day = class2day.substring(1, class2day.length - 1);
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
                      showclasscode = 2;
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
  void _showSlideUpPanelclass3(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85, // Set maximum height,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (newValue) {
                      setState(() {
                        panelValue = newValue; // Update the state
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Class Info'),
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
                        classsendcode = 3;
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
                        class3name = val as String;
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
                        class3room = val as String;
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
                      ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: time);
                          if(newTime == null){
                            return;
                          }
                          setState(() {
                            time = newTime;
                            timesendcode = 3;
                          });
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
                        child: Text(
                          time.format(context) ?? 'Select start time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: time2);
                          if(newTime == null){
                            return;
                          }
                          setState(() {
                            time2 = newTime;
                            timesendcode = 3;
                          });
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
                        child: Text(
                          time2.format(context) ?? 'Select end time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
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
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)],
                        tileMode:
                        TileMode.repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    onSelect: (values) { // <== Callback to handle the selected days
                      print(values);
                      class3day = values.toString();
                      class3day = class3day.substring(1, class3day.length - 1);
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
                      showclasscode = 3;
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
      final hours = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString();
      //class1time = "$timepart1:$timepart2 - $timepart3:$timepart4 $timepart5";
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

      prefs.setString('class1_Name', class1name);
      prefs.setString('class2_Name', class2name);

      prefs.setString('class1_Time', class1time);
      prefs.setString('class2_Time', class2time);

      prefs.setString('class1_Day', class1day);
      prefs.setString('class2_Day', class2day);

      prefs.setString('class1_image', class1image);
      prefs.setString('class2_image', class2image);

      prefs.setString('class1_Room', class1room);
      prefs.setString('class2_Room', class2room);
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

  // void togpress() async{
  //   setState(() {
  //     if(!montog && sendcodec1 == 1){
  //       togcolor = Color.fromARGB(255, 0, 107, 103);
  //       montog = true;
  //       daypart1 = "Mon/";
  //     }
  //     else if(montog && sendcodec1 == 1){
  //       togcolor = Color.fromARGB(255, 241, 138, 32);
  //       daypart1 = "";
  //       montog = false;
  //     }
  //     if(!tuetog && sendcodec1 == 2){
  //       togcolor2 = Color.fromARGB(255, 0, 107, 103);
  //       tuetog = true;
  //       daypart2 = "Tue/";
  //     }
  //     else if(tuetog && sendcodec1 == 2){
  //       togcolor2 = Color.fromARGB(255, 241, 138, 32);
  //       daypart2 = "";
  //       tuetog = false;
  //     }
  //     if(!wedtog&& sendcodec1 == 3){
  //       togcolor3 = Color.fromARGB(255, 0, 107, 103);
  //       wedtog = true;
  //       daypart3 = "Tue/";
  //     }
  //     else if(wedtog&& sendcodec1 == 3){
  //       togcolor3 = Color.fromARGB(255, 241, 138, 32);
  //       daypart3 = "";
  //       wedtog = false;
  //     }
  //     if(!thurtog && sendcodec1 == 4){
  //       togcolor4 = Color.fromARGB(255, 0, 107, 103);
  //       thurtog = true;
  //       daypart4 = "Thur/";
  //     }
  //     else if(thurtog && sendcodec1 == 4){
  //       togcolor4 = Color.fromARGB(255, 241, 138, 32);
  //       daypart4 = "";
  //       thurtog = false;
  //     }
  //     if(!fritog && sendcodec1 == 5){
  //       togcolor5 = Color.fromARGB(255, 0, 107, 103);
  //       fritog = true;
  //       daypart5 = "Fri/";
  //     }
  //     else if(fritog && sendcodec1 == 5){
  //       togcolor5 = Color.fromARGB(255, 241, 138, 32);
  //       daypart5 = "";
  //       fritog = false;
  //     }
  //     if(!sattog && sendcodec1 == 6){
  //       togcolor6 = Color.fromARGB(255, 0, 107, 103);
  //       sattog = true;
  //       daypart6 = "Sat/";
  //     }
  //     else if(sattog && sendcodec1 == 6){
  //       togcolor6 = Color.fromARGB(255, 241, 138, 32);
  //       daypart6 = "";
  //       sattog = false;
  //     }
  //     if(!suntog && sendcodec1 == 7){
  //       togcolor7 = Color.fromARGB(255, 0, 107, 103);
  //       suntog = true;
  //       daypart7 = "Sun/";
  //     }
  //     else if(suntog && sendcodec1 == 7){
  //       togcolor7 = Color.fromARGB(255, 241, 138, 32);
  //       daypart7 = "";
  //       suntog = false;
  //     }
  //     sendcodec1 = 0;
  //   });
  // }

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
      if(showclasscode == 1){
        prefs.setBool('ShowClass1', false);
      }
      else if (showclasscode == 2){
        prefs.setBool('ShowClass2', false);
      }
      else if (showclasscode == 3){
        prefs.setBool('ShowClass3', false);
      }
      else if (showclasscode == 4){
        prefs.setBool('ShowClass4', false);
      }
      else if (showclasscode == 5){
        prefs.setBool('ShowClass5', false);
      }
      else if (showclasscode == 6){
        prefs.setBool('ShowClass6', false);
      }
      else if (showclasscode == 7){
        prefs.setBool('ShowClass7', false);
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
