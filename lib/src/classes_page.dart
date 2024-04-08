import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:interactivemap/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:day_picker/day_picker.dart';



class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  _ClassPage createState() => _ClassPage();
}

class _ClassPage extends State<ClassPage>{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance(); //makes the shared prefrences update when changed right away

  @override
  void initState() {
    //loads data on startup
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
  ]; //used for the list of days for the day selector

  Color textColor= Color.fromARGB(255, 141, 185, 202); // avc blue text for the class cards


  //colors for testing things
  final Color avcorange = Color.fromARGB(255, 241, 138, 32); // avc orange
  final Color avcblue = Color.fromARGB(255, 141, 185, 202);// avc blue
  final Color avcgreen = Color.fromARGB(255, 0, 107, 103); // avc green

  //default lat and lon for if the class does not have cords
  double latitudeClass1 = 34.67613026710341;
  double longitudeClass1 = -118.19203306356845;

  
  String? selectedItem = 'Select a class';


Map<String, String> imgmap = {
  'Select a class': '',
  'CSUB/CSU Bakersfield': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_bakersfield.jpg?raw=true',
  'DL/Discovery Lab': '',
  'AL/Auto Lab': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_autolab.jpg?raw=true',
  'UH/Uhazy Hall': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_uhazyhall.jpg?raw=true',
  'YH/Yoshida Hall': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_yoshidahall.jpg?raw=true',
  'S1-9/SOAR High School': '',
  'PA/Performing Arts Theatre': '',
  'FA1/Art Gallery': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_artgallery.jpg?raw=true',
  'FA2/Black Box': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_blackbox.jpg?raw=true',
  'MH/Mesquite Hall': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_mh.jpg?raw=true',
  'LH/Lecture Hall': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_lh.jpg?raw=true',
  'SH/Sage Hall': 'https://www.avc.edu/sites/default/files/inline-images/nov2021-1.png?raw=true',
  'ME/Math and Engineering': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_me.jpg?raw=true',
  'FA4/Fine Arts': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_finearts.jpg?raw=true',
  'FA3/Fine Arts Music and Offices': '',
  'EL/Enterprise Lab': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_enterpriselab.jpg?raw=true',
  'HL/Horticulture Lab': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_horticulture.jpg?raw=true',
  'GH1-4/Greenhouses': 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_greenhouse.jpg?raw=true',
};

Map<String, double> latMap = {
    'Select a class': 34.678652329599096,
    'CSUB/CSU Bakersfield': 34.680353586506165,
    'DL/Discovery Lab': 34.680452828358916,
    'AL/Auto Lab': 34.67882218077683,
    'UH/Uhazy Hall': 34.6788359665366,
    'YH/Yoshida Hall': 34.67899187744454,
    'S1-9/SOAR High School': 34.67877310935158,
    'PA/Performing Arts Theatre': 34.6754613377245,
    'FA1/Art Gallery': 34.676203764577544,
    'FA2/Black Box': 34.675832701065104,
    'MH/Mesquite Hall': 34.67687342944362,
    'LH/Lecture Hall': 34.677011511466674,
    'SH/Sage Hall': 34.67714651488922,
    'ME/Math and Engineering': 34.67775573632852,
    'FA4/Fine Arts': 34.67648676160919,
    'FA3/Fine Arts Music and Offices': 34.67626532974614,
    'EL/Enterprise Lab': 34.67973186506707,
    'HL/Horticulture Lab': 34.679898891625314,
    'GH1-4/Greenhouses': 34.679813863502766,
};

Map<String, double> lonMap = {
    'Select a class': -118.18616290156892,
    'CSUB/CSU Bakersfield': -118.18506976951421,
    'DL/Discovery Lab': -118.18656003661856,
    'AL/Auto Lab': -118.18719722438767,
    'UH/Uhazy Hall': -118.18640225876932,
    'YH/Yoshida Hall': -118.18548358738202,
    'S1-9/SOAR High School': -118.18800679457378,
    'PA/Performing Arts Theatre': -118.18723230937766,
    'FA1/Art Gallery': -118.18697930907051,
    'FA2/Black Box': -118.18737862660834,
    'MH/Mesquite Hall': -118.18512883579885,
    'LH/Lecture Hall': -118.18741261041862,
    'SH/Sage Hall': -118.18709120662562,
    'ME/Math and Engineering': -118.18589961736947,
    'FA4/Fine Arts': -118.18738628333938,
    'FA3/Fine Arts Music and Offices': -118.18770778514867,
    'EL/Enterprise Lab': -118.18654794631942,
    'HL/Horticulture Lab': -118.1870825677824,
    'GH1-4/Greenhouses': -118.18775289064219,
};
  
    // List<double> classlatlist = [
    //   34.678652329599096, 
    //   34.680353586506165,  
    //   34.680452828358916,  
    //   34.67882218077683,   
    //   34.6788359665366,   
    //   34.67899187744454,  
    //   34.67877310935158,  
    //   34.6754613377245,   
    //   34.676203764577544, 
    //   34.675832701065104, 
    //   34.67687342944362,  
    //   34.677011511466674, 
    //   34.67714651488922,  
    //   34.67775573632852,  
    //   34.67648676160919,  
    //   34.67626532974614,  
    //   34.67973186506707,  
    //   34.679898891625314, 
    //   34.679813863502766
    // ];
    // List<double> classlonlist = [
    //   -118.18616290156892, //select a class
    //   -118.18506976951421,
    //   -118.18656003661856,
    //   -118.18719722438767,
    //   -118.18640225876932,
    //   -118.18548358738202,
    //   -118.18800679457378,
    //   -118.18723230937766,
    //   -118.18697930907051,
    //   -118.18737862660834,
    //   -118.18512883579885,
    //   -118.18741261041862,
    //   -118.18709120662562,
    //   -118.18589961736947,
    //   -118.18738628333938,
    //   -118.18770778514867,
    //   -118.18654794631942,
    //   -118.1870825677824,
    //   -118.18775289064219
    // ];
    
    List<String> classList = [
      'Select a class', 
      'CSUB/CSU Bakersfield', 
      'DL/Discovery Lab ', 
      'AL/Auto Lab', 
      'UH/Uhazy Hall', 
      'YH/Yoshida Hall', 
      'S1-9/SOAR High School', 
      'PA/Performing Arts Theatre', 
      'FA1/Art Gallery', 
      'FA2/Black Box', 
      'MH/Mesquite Hall', 
      'LH/Lecture Hall', 
      'SH/Sage Hall', 
      'ME/Math and Engineering', 
      'FA4/Fine Arts', 
      'FA3/Fine Arts Music and Offices', 
      'EL/Enterprise Lab', 
      'HL/Horticulture Lab', 
      'GH1-4/Greenhouses'
      ];

    // List<String> classimglist = [
    //   '',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_bakersfield.jpg?raw=true',
    //   '',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_autolab.jpg?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_uhazyhall.jpg?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_yoshidahall.jpg?raw=true',
    //   '',
    //   '',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_artgallery.jpg?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_blackbox.jpg?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_mh.jpg?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_lh.jpg?raw=true',
    //   'https://www.avc.edu/sites/default/files/inline-images/nov2021-1.png?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_me.jpg?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_finearts.jpg?raw=true',
    //   '',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_enterpriselab.jpg?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_horticulture.jpg?raw=true',
    //   'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_greenhouse.jpg?raw=true',
    // ];
    
  //time for the time selector
  TimeOfDay time = const TimeOfDay(hour: 1, minute: 00);
  TimeOfDay time2 = const TimeOfDay(hour: 1, minute: 00);


  late String timepart1 = "01"; //first time slot
  late String timepart2 = "00"; //2nd time slot

  late int classmanagecode = 0;   //used to select which class is picked when you press manage

  late int timesendcode = 0;     //used to know what class is being selected for time when you press save

  late int classpickGO = 0;     //used to know what class go is being pressed for

  late String classforCords = "";  //used to match class name to cords

  //used to show the next 'add a class' button
  late bool shownext2 = false;
  late bool shownext3 = false;
  late bool shownext4 = false;
  late bool shownext5 = false;
  late bool shownext6 = false;
  late bool shownext7 = false;

  //used to show the class once you press the add class button
  late bool showclass1 = false;
  late bool showclass2 = false;
  late bool showclass3 = false;
  late bool showclass4 = false;
  late bool showclass5 = false;
  late bool showclass6 = false;
  late bool showclass7 = false;

  late int addclasssendcode = 0; //used to know what class the add class button was pressed for so it can make it visable

  late String buldingselect = "";  //used for cords to know what building was selected

  //used holds the name of the building selected
  late String building1select = "";
  late String building2select = "";
  late String building3select = "";
  late String building4select = "";
  late String building5select = "";
  late String building6select = "";
  late String building7select = "";

  //the name of the class, like bio 101
  late String class1name = "";
  late String class2name = "";
  late String class3name = "";
  late String class4name = "";
  late String class5name = "";
  late String class6name = "";
  late String class7name = "";

  //used for the class time
  late String class1time = "";
  late String class2time = "";
  late String class3time = "";
  late String class4time = "";
  late String class5time = "";
  late String class6time = "";
  late String class7time = "";

  //used for class day
  late String class1day = "";
  late String class2day = "";
  late String class3day = "";
  late String class4day = "";
  late String class5day = "";
  late String class6day = "";
  late String class7day = "";

  //used for the class image
  late String class1image = "";
  late String class2image = "";
  late String class3image = "";
  late String class4image = "";
  late String class5image = "";
  late String class6image = "";
  late String class7image = "";

  //used for the room number
  late String class1room = "";
  late String class2room = "";
  late String class3room = "";
  late String class4room = "";
  late String class5room = "";
  late String class6room = "";
  late String class7room = "";

  late Map<String, Object> data = {};

  //all of is is used to load the data from shared prefrences
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

      building1select = prefs.getString('Class1Select') ?? '';
      building2select = prefs.getString('Class2Select') ?? '';
      building3select = prefs.getString('Class3Select') ?? '';
      building4select = prefs.getString('Class4Select') ?? '';
      building5select = prefs.getString('Class5Select') ?? '';
      building6select = prefs.getString('Class6Select') ?? '';
      building7select = prefs.getString('Class7Select') ?? '';

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
                        Text(building1select,
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
               classpickGO = 1;
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
            Visibility(
                  visible: showclass1,
                  child: Column(children: [
                    const Divider(thickness: 5, color: Colors.transparent,),
                    const Divider(thickness: 5, color: Colors.transparent,),
                    const Divider(thickness: 5, color: Colors.transparent,),
                  ],),
                ),
            //end class 1 ------------------------------------------------------

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
                      Text(building2select,
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
                classpickGO = 2;
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
            Visibility(
                  visible: showclass2,
                  child: Column(children: [
                    const Divider(thickness: 5, color: Colors.transparent,),
                    const Divider(thickness: 5, color: Colors.transparent,),
                    const Divider(thickness: 5, color: Colors.transparent,),
                  ],),
                ),
            //end class 2 ------------------------------------------------------

   
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
                        Text(building3select,
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
               classpickGO = 3;
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
            Visibility(
                  visible: showclass3,
                  child: const Column(children: [
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                  ],),
                ),
                


            
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
                        Text(building4select,
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
               classpickGO = 4;
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
            Visibility(
                  visible: showclass4,
                  child: const Column(children: [
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                  ],),
                ),


    /// CLASS 5 -------------------------------------------------------------------------------------------------------------------
            showclass5 ? Container(
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
                        FadeInImage(image: NetworkImage(class5image),
                          placeholder: const AssetImage('assets/images/here_you_go_bblake.png'),
                          imageErrorBuilder: (c, o, s) => Image.asset(
                              'assets/images/image_avc_logo.png',
                            height: 100,
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Text(building5select,
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
                            Text(class5name,
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
                            Text(class5room,
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
                            Text(class5time,
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
                            Text(class5day,
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
                              classmanagecode = 5;
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
           showclass5 ? ElevatedButton(
             onPressed: (){
               classpickGO = 5;
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
            Visibility(
                  visible: showclass5,
                  child: const Column(children: [
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                  ],),
                ),

            //CLASS 6 -------------------------------------------------------------------------------------------------------------------
            showclass6 ? Container(
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
                        FadeInImage(image: NetworkImage(class6image),
                          placeholder: const AssetImage('assets/images/here_you_go_bblake.png'),
                          imageErrorBuilder: (c, o, s) => Image.asset(
                              'assets/images/image_avc_logo.png',
                            height: 100,
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Text(building6select,
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
                            Text(class6name, // This should likely be class6name, assuming a similar pattern
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
                            Text(class6room,
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
                            Text(class6time,
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
                            Text(class6day,
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
                              classmanagecode = 6;
                            });
                            _showSlideUpPanelclass1(context);
                          },
                        ),
                      ],
                    ), //),
                  )
                ],
              ),
            ) : const SizedBox(),
            showclass6 ? ElevatedButton(
              onPressed: (){
                classpickGO = 6;
                goPress();
              },
              style: ButtonStyle(
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
            Visibility(
                  visible: showclass6,
                  child: const Column(children: [
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                  ],),
                ),

            //CLASS 7 -------------------------------------------------------------------------------------------------------------------
            showclass7 ? Container(
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
                        FadeInImage(image: NetworkImage(class7image),
                          placeholder: const AssetImage('assets/images/here_you_go_bblake.png'),
                          imageErrorBuilder: (c, o, s) => Image.asset(
                              'assets/images/image_avc_logo.png',
                            height: 100,
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Text(building7select,
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
                            Text(class7name, // Update to class7name accordingly
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
                            Text(class7room,
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
                            Text(class7time,
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
                            Text(class7day,
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
                              classmanagecode = 7;
                            });
                            _showSlideUpPanelclass1(context);
                          },
                        ),
                      ],
                    ), //),
                  )
                ],
              ),
            ) : const SizedBox(),
            showclass7 ? ElevatedButton(
              onPressed: (){
                classpickGO = 7;
                goPress();
              },
              style: ButtonStyle(
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
            Visibility(
                  visible: showclass7,
                  child: const Column(children: [
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                    Divider(thickness: 5, color: Colors.transparent,),
                  ],),
                ),

          ],
        ),
      ),
       floatingActionButton: FloatingActionButton.extended(
        backgroundColor: textColor,
          icon: const Icon(Icons.add),
          label: const Text('Add Class'),
          onPressed: () {
            classaddbutton();
          },
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
                          building1select = val as String;
                        }
                        else if(classmanagecode == 2){
                          building2select = val as String;
                        }
                        else if(classmanagecode == 3){
                          building3select = val as String;
                        }
                        else if(classmanagecode == 4){
                          building4select = val as String;
                        }
                        else if(classmanagecode == 5){
                          building5select = val as String;
                        }
                        else if(classmanagecode == 6){
                          building6select = val as String;
                        }
                        else if(classmanagecode == 7){
                          building7select = val as String;
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
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          int? previousHour = prefs.getInt('selectedHour');
                          int? previousMinute = prefs.getInt('selectedMinute');
                          TimeOfDay initialTime = previousHour != null && previousMinute != null
                              ? TimeOfDay(hour: previousHour, minute: previousMinute)
                              : TimeOfDay.now(); // or any other default time
                          TimeOfDay? newTime = await showTimePicker(context: context,initialTime: initialTime,);
                          if (newTime == null) {
                              return;
                          }
                          // Save the selected time
                          await prefs.setInt('selectedHour', newTime.hour);
                          await prefs.setInt('selectedMinute', newTime.minute);

                          setState(() {
                              time = newTime;
                              if (classmanagecode == 1) {
                                  timesendcode = 1;
                              } else if (classmanagecode == 2) {
                                  timesendcode = 2;
                              } else if (classmanagecode == 3) {
                                  timesendcode = 3;
                              } else if (classmanagecode == 4) {
                                  timesendcode = 4;
                              } else if (classmanagecode == 5) {
                                  timesendcode = 5;
                              } else if (classmanagecode == 6) {
                                  timesendcode = 6;
                              } else if (classmanagecode == 7) {
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
                      //print(values);
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

    String? selectedimg = "";
    selectedimg = imgmap[buldingselect];

    
    if (classmanagecode == 1) {
      class1image = selectedimg!;
    } else if (classmanagecode == 2) {
      class2image = selectedimg!;
    } else if (classmanagecode == 3) {
      class3image = selectedimg!;
    } else if (classmanagecode == 4) {
      class4image = selectedimg!;
    } else if (classmanagecode == 5) {
      class5image = selectedimg!;
    } else if (classmanagecode == 6) {
      class6image = selectedimg!;
    } else if (classmanagecode == 7) {
      class7image = selectedimg!;
    }

    if (timesendcode == 1) {
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class1time = "$timepart1 - $timepart2";
    } else if (timesendcode == 2) {
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class2time = "$timepart1 - $timepart2";
    } else if (timesendcode == 3) {
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class3time = "$timepart1 - $timepart2";
    } else if (timesendcode == 4) {
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class4time = "$timepart1 - $timepart2";
    } else if (timesendcode == 5) {
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class5time = "$timepart1 - $timepart2";
    } else if (timesendcode == 6) {
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class6time = "$timepart1 - $timepart2";
    } else if (timesendcode == 7) {
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class7time = "$timepart1 - $timepart2";
    }

    setState(() {
      prefs.setString('Class1Select', building1select);
      prefs.setString('Class2Select', building2select);
      prefs.setString('Class3Select', building3select);
      prefs.setString('Class4Select', building4select);
      prefs.setString('Class5Select', building5select);
      prefs.setString('Class6select', building6select);
      prefs.setString('Class7Select', building7select);

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
    Navigator.pop(context);
  }

  void clearData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.clear();
      prefs.setBool('ShowClass1', false);
    });
  }


  void classaddbutton() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

      if(showclass1 == false){
        showclass1 = true;
      }
      else if(showclass2 == false){
        showclass2 = true;
      }
      else if(showclass3 == false){
        showclass3 = true;
      }
      else if(showclass4 == false){
        showclass4 = true;
      }
      else if(showclass5 == false){
        showclass5 = true;
      }
      else if(showclass6 == false){
        showclass6 = true;
      }
      else if(showclass7 == false){
        showclass7 = true;
      }
      // add so if they reach max ther is an alert
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
      //prefs.clear();
      if(classmanagecode == 1){
        prefs.setBool('ShowClass1', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (classmanagecode == 2){
        prefs.setBool('ShowClass2', false);

        prefs.setBool('shownext2', true);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (classmanagecode == 3){
        prefs.setBool('ShowClass3', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', true);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (classmanagecode == 4){
        prefs.setBool('ShowClass4', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', true);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (classmanagecode == 5){
        prefs.setBool('ShowClass5', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', true);
        prefs.setBool('shownext6', false);
        prefs.setBool('shownext7', false);
      }
      else if (classmanagecode == 6){
        prefs.setBool('ShowClass6', false);

        prefs.setBool('shownext2', false);
        prefs.setBool('shownext3', false);
        prefs.setBool('shownext4', false);
        prefs.setBool('shownext5', false);
        prefs.setBool('shownext6', true);
        prefs.setBool('shownext7', false);
      }
      else if (classmanagecode == 7){
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

    if (classpickGO == 1){
      classforCords = building1select;
    }
    else if(classpickGO == 2){
      classforCords = building2select;
    }
    else if(classpickGO == 3){
      classforCords = building3select;
    }
    else if(classpickGO == 4){
      classforCords = building4select;
    }
    else if(classpickGO == 5){
      classforCords = building5select;
    }
    else if(classpickGO == 6){
      classforCords = building6select;
    }

   
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp(latitude: latMap[classforCords], longitude: lonMap[classforCords], zoom: 19,)),
      );
  }
}
