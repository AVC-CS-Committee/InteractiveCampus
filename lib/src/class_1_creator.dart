import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Class1creator extends StatefulWidget {
  const Class1creator({super.key});
  @override
  _Class1creator createState() => _Class1creator();
}
class _Class1creator extends State<Class1creator> {

  late String class1Select = "";
  late String class1name = "";
  late String class1time = "";
  late String class1day = "";
  late String class1image = "https://www.avc.edu/themes/custom/antelopevc/logo.svg" ;
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

  List<String> classtimeList1 = ['1', '2', '3','4','5','6','7','8','9','10','11','12'];
  List<String> classtimeList2 = ['00', '05', '10','15','20','25','30','35','40','45','50','55'];
  List<String> classtimeList3 = ['a.m.', 'p.m.'];
  String? selectedtimeitem1 = '1';
  String? selectedtimeitem2 = '00';
  String? selectedtimeitem3 = '1';
  String? selectedtimeitem4 = '00';
  String? selectedtimeitem5 = 'p.m.';

  Color togcolor = Color.fromARGB(255, 241, 138, 32);
  Color togcolor2 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor3 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor4 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor5 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor6 = Color.fromARGB(255, 241, 138, 32);
  Color togcolor7 = Color.fromARGB(255, 241, 138, 32);

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
          padding: EdgeInsets.all(25),
          children: [
            const Text('Class Information',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
            const Divider(),
            DropdownButton(
              value: selectedItem,
              items: classList.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
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
                labelText: 'Name',
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
            Text("Time:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: selectedtimeitem1,
                  items: classtimeList1.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                  onChanged: (val) {
                    setState((){
                      selectedtimeitem1 = val as String;
                      timepart1 = val as String;
                    });
                    timesendcode = 1;
                  },
                ),
                const Text(":",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8a1c40)
                  ),
                ),
                DropdownButton(
                  value: selectedtimeitem2,
                  items: classtimeList2.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                  onChanged: (val) {
                    setState((){
                      selectedtimeitem2 = val as String;
                      timepart2 = val as String;
                    });
                    timesendcode = 1;
                  },
                ),
                const Text("-",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8a1c40)
                  ),
                ),
                DropdownButton(
                  value: selectedtimeitem3,
                  items: classtimeList1.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                  onChanged: (val) {
                    setState((){
                      selectedtimeitem3 = val as String;
                      timepart3 = val as String;
                    });
                    timesendcode = 1;
                  },
                ),
                const Text(":",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8a1c40)
                  ),
                ),
                DropdownButton(
                  value: selectedtimeitem4,
                  items: classtimeList2.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                  onChanged: (val) {
                    setState((){
                      selectedtimeitem4 = val as String;
                      timepart4 = val as String;
                    });
                    timesendcode = 1;
                  },
                ),
                DropdownButton(
                  value: selectedtimeitem5,
                  items: classtimeList3.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                  onChanged: (val) {
                    setState((){
                      selectedtimeitem5 = val as String;
                      timepart5 = val as String;
                    });
                    timesendcode = 1;
                  },
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Room number',
              ),
              onChanged: (val) {
                setState((){
                  class1room = val as String;
                });
              },
            ),
           const Divider(
             thickness: 3,
             color: Colors.transparent,
           ),
           const Text("Days:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: (){
                  sendcode = 1;
                  togpress();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: togcolor,
                ),
                child: const Text("Mon"),
              ),
              OutlinedButton(
                onPressed: (){
                  sendcode = 2;
                  togpress();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: togcolor2,
                ),
                child: const Text("Tue"),
              ),
              OutlinedButton(
                onPressed: (){
                  sendcode = 3;
                  togpress();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: togcolor3,
                ),
                child: const Text("Wed"),
              ),
              OutlinedButton(
                onPressed: (){
                  sendcode = 4;
                  togpress();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: togcolor4,
                ),
                child: const Text("Thur"),
              ),
              OutlinedButton(
                onPressed: (){
                  sendcode = 5;
                  togpress();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: togcolor5,
                ),
                child: const Text("Fri"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              OutlinedButton(
                onPressed: (){
                  sendcode = 6;
                  togpress();
                },
                child: const Text("Sat"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: togcolor6,
                ),
              ),
              OutlinedButton(
                onPressed: (){
                  sendcode = 7;
                  togpress();
                },
                child: const Text("Sun"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: togcolor7,
                ),
              ),
            ],
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
                'Save class information',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: (){
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
                'Clear class information',
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


  void saveData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (class1Select == 'CSUB/CSU Bakersfield'){

    }
    else if (class1Select == 'DL/Discovery Lab'){

    }
    else if (class1Select == 'AL/Auto Lab'){

    }
    else if (class1Select == 'UH/Uhazy Hall'){
      class1image = "https://www.avc.edu/sites/default/files/inline-images/measureavFeb25-002.jpg";
    }
    else if (class1Select == 'YH/Yoshida Hall'){

    }
    else if (class1Select == 'S1-9/SOAR High School'){

    }
    else if (class1Select == 'PA/Performing Arts Theatre'){

    }
    else if (class1Select == 'FA1/Art Gallery'){

    }
    else if (class1Select == 'FA2/Black Box'){

    }
    else if (class1Select == 'MH/Mesquite Hall'){

    }
    else if (class1Select == 'LH/Lecture Hall'){

    }
    else if (class1Select == 'SH/Sage Hall'){
      class1image = "https://www.avc.edu/sites/default/files/inline-images/nov2021-1.png";
    }
    else if (class1Select == 'ME/Math and Engineering'){

    }
    else if (class1Select == 'FA4/Fine Arts'){

    }
    else if (class1Select == 'FA3/Fine Arts Music and Offices'){

    }
    else if (class1Select == 'EL/Enterprise Lab'){

    }
    else if (class1Select == 'HL/Horticulture Lab'){

    }
    else if (class1Select == 'GH1-4/Greenhouses'){

    }
    else{

    }

    if(timesendcode > 0){
      class1time = "$timepart1:$timepart2 - $timepart3:$timepart4 $timepart5";
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
    setState(() {
      prefs.setString('Class1Select' , '');
      prefs.setString('class1_Name', '');
      prefs.setString('class1_Day', '');
      prefs.setString('class1_Time', '');
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
