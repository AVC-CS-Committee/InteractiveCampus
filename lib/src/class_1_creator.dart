import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:interactivemap/src/classes_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:day_picker/day_picker.dart';

class Class1creator extends StatefulWidget {
  const Class1creator({super.key});
  @override
  _Class1creator createState() => _Class1creator();
}
class _Class1creator extends State<Class1creator> {
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

  TimeOfDay time = const TimeOfDay(hour: 1, minute: 00);
  TimeOfDay time2 = const TimeOfDay(hour: 1, minute: 00);

  late int classselect = 0;


  late bool showclass1 = false;

  late bool classdeletetog = false;

  late String class1Select = "";
  late String class1name = "";
  late String class1time = "";
  late String class1day = "";
  late String class1image = "" ;
  late String class1room = "";

  late String timepart1 = "01";
  late String timepart2 = "00";
  late String timepart3 = "1";
  late String timepart4 = "00";
  late String timepart5 = "p.m.";

  late String daypart1 = class1day;
  late String daypart2 = "";
  late String daypart3 = "";
  late String daypart4 = "";
  late String daypart5 = "";
  late String daypart6 = "";
  late String daypart7 = "";

  late bool montog = false;
  late bool tuetog = false;
  late bool wedtog = false;
  late bool thurtog = false;
  late bool fritog = false;
  late bool sattog = false;
  late bool suntog = false;

  late int sendcode = 0;
  late int timesendcode = 0;

  late Map<String, Object> data = {};

  @override
  void initState() {
    loadData();
    super.initState();
  }



  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showclass1 = prefs.getBool('ShowClass1') ?? false;
      class1Select = prefs.getString('Class1Select') ?? '';
      class1name = prefs.getString('class1_Name') ?? '';
      class1time = prefs.getString('class1_Time') ?? '';
      class1day = prefs.getString('class1_Day') ?? '';
      class1image = prefs.getString('class1_image') ?? '';
      class1room = prefs.getString('class1_Room') ?? '';
      var dataString = prefs.getString('data');
      data = dataString != null ? Map<String, Object>.from(jsonDecode(dataString)): {};
    });
  }

  //const ClassPage({Key? key}) : super(key: key);
  List<String> classList = ['Select a class', 'CSUB/CSU Bakersfield', 'DL/Discovery Lab ', 'AL/Auto Lab', 'UH/Uhazy Hall', 'YH/Yoshida Hall', 'S1-9/SOAR High School', 'PA/Performing Arts Theatre', 'FA1/Art Gallery', 'FA2/Black Box', 'MH/Mesquite Hall', 'LH/Lecture Hall', 'SH/Sage Hall', 'ME/Math and Engineering', 'FA4/Fine Arts', 'FA3/Fine Arts Music and Offices', 'EL/Enterprise Lab', 'HL/Horticulture Lab', 'GH1-4/Greenhouses'];
  String? selectedItem = 'Select a class';

  Color togcolor = Color.fromARGB(255, 241, 138, 32);
  Color togcolor2 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor3 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor4 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor5 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor6 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor7 = Color.fromARGB(255, 241, 138, 32);

  @override
  Widget build(BuildContext context){
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

      // bottomNavigationBar: BottomAppBar(
      //       color: Colors.transparent,
      //       child:
      //       SizedBox(
      //         child: ElevatedButton(
      //           onPressed: (){
      //             saveData();
      //           },
      //           style:  const ButtonStyle(
      //             backgroundColor: MaterialStatePropertyAll(
      //               Color(0xff006b67),
      //             ),
      //           ),
      //           child: const Text(
      //             'Save class information',
      //             style: TextStyle(
      //               fontSize: 25,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ),
      // ),

      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            classdeletetog ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xff006b67),
              ),
              child: const Text('Class removed',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ): const SizedBox(),
            const Text('Class Information',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
            const Divider(
              thickness: 3,
              color: Colors.transparent,
            ),
            //start of the container for all the inputs -----------------------------------------------
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select a building',
              ),
              items:classList.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
              onChanged: (val) {
                setState((){
                  selectedItem = val as String;
                  class1Select = val as String;
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
                showAlert;
                clearData();
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
      ),
    );
  }

  void showAlert() async {

  }

  void saveData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (class1Select == 'CSUB/CSU Bakersfield'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_bakersfield.jpg?raw=true';
    }
    else if (class1Select == 'DL/Discovery Lab'){

    }
    else if (class1Select == 'AL/Auto Lab'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_autolab.jpg?raw=true';
    }
    else if (class1Select == 'UH/Uhazy Hall'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_uhazyhall.jpg?raw=true';
    }
    else if (class1Select == 'YH/Yoshida Hall'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_yoshidahall.jpg?raw=true';
    }
    else if (class1Select == 'S1-9/SOAR High School'){
      class1image = '';
    }
    else if (class1Select == 'PA/Performing Arts Theatre'){
      class1image = '';
    }
    else if (class1Select == 'FA1/Art Gallery'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_artgallery.jpg?raw=true';
    }
    else if (class1Select == 'FA2/Black Box'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_blackbox.jpg?raw=true';
    }
    else if (class1Select == 'MH/Mesquite Hall'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_mh.jpg?raw=true';
    }
    else if (class1Select == 'LH/Lecture Hall'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_lh.jpg?raw=true';
    }
    else if (class1Select == 'SH/Sage Hall'){
      class1image = "https://www.avc.edu/sites/default/files/inline-images/nov2021-1.png?raw=true";
    }
    else if (class1Select == 'ME/Math and Engineering'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_me.jpg?raw=true';
    }
    else if (class1Select == 'FA4/Fine Arts'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_finearts.jpg?raw=true';
    }
    else if (class1Select == 'FA3/Fine Arts Music and Offices'){
      class1image = '';
    }
    else if (class1Select == 'EL/Enterprise Lab'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_enterpriselab.jpg?raw=true';
    }
    else if (class1Select == 'HL/Horticulture Lab'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_horticulture.jpg?raw=true';
    }
    else if (class1Select == 'GH1-4/Greenhouses'){
      class1image = 'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_greenhouse.jpg?raw=true';
    }

    if(timesendcode > 0){
      final hours = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString();
      //class1time = "$timepart1:$timepart2 - $timepart3:$timepart4 $timepart5";
      timepart1 = time.format(context);
      timepart2 = time2.format(context);
      class1time = "$timepart1 - $timepart2";
    }

    if(sendcode > 0) {
      class1day = daypart1 + daypart2 + daypart3 + daypart4 + daypart5 + daypart6 + daypart7;
      class1day = class1day.substring(0, class1day.length - 1); //used to chop off the / at the end of the words
    }
    setState(() {
      prefs.setString('Class1Select', class1Select);
      prefs.setString('class1_Name', class1name);
      prefs.setString('class1_Time', class1time);
      prefs.setString('class1_Day', class1day);
      prefs.setString('class1_image', class1image);
      prefs.setString('class1_Room', class1room);
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
  void togpress() async{
    setState(() {
      if(!montog && sendcode == 1){
        togcolor = Color.fromARGB(255, 0, 107, 103);
        montog = true;
        daypart1 = "Mon/";
      }
      else if(montog && sendcode == 1){
        togcolor = Color.fromARGB(255, 241, 138, 32);
        daypart1 = "";
        montog = false;
      }
      if(!tuetog && sendcode == 2){
        togcolor2 = Color.fromARGB(255, 0, 107, 103);
        tuetog = true;
        daypart2 = "Tue/";
      }
      else if(tuetog && sendcode == 2){
        togcolor2 = Color.fromARGB(255, 241, 138, 32);
        daypart2 = "";
        tuetog = false;
      }
      if(!wedtog&& sendcode == 3){
        togcolor3 = Color.fromARGB(255, 0, 107, 103);
        wedtog = true;
        daypart3 = "Tue/";
      }
      else if(wedtog&& sendcode == 3){
        togcolor3 = Color.fromARGB(255, 241, 138, 32);
        daypart3 = "";
        wedtog = false;
      }
      if(!thurtog && sendcode == 4){
        togcolor4 = Color.fromARGB(255, 0, 107, 103);
        thurtog = true;
        daypart4 = "Thur/";
      }
      else if(thurtog && sendcode == 4){
        togcolor4 = Color.fromARGB(255, 241, 138, 32);
        daypart4 = "";
        thurtog = false;
      }
      if(!fritog && sendcode == 5){
        togcolor5 = Color.fromARGB(255, 0, 107, 103);
        fritog = true;
        daypart5 = "Fri/";
      }
      else if(fritog && sendcode == 5){
        togcolor5 = Color.fromARGB(255, 241, 138, 32);
        daypart5 = "";
        fritog = false;
      }
      if(!sattog && sendcode == 6){
        togcolor6 = Color.fromARGB(255, 0, 107, 103);
        sattog = true;
        daypart6 = "Sat/";
      }
      else if(sattog && sendcode == 6){
        togcolor6 = Color.fromARGB(255, 241, 138, 32);
        daypart6 = "";
        sattog = false;
      }
      if(!suntog && sendcode == 7){
        togcolor7 = Color.fromARGB(255, 0, 107, 103);
        suntog = true;
        daypart7 = "Sun/";
      }
      else if(suntog && sendcode == 7){
        togcolor7 = Color.fromARGB(255, 241, 138, 32);
        daypart7 = "";
        suntog = false;
      }
    });
  }
}
