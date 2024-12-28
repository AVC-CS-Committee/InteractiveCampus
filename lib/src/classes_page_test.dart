import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:interactivemap/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:day_picker/day_picker.dart';

class ClassPageTest extends StatefulWidget {
  const ClassPageTest({super.key});

  @override
  _ClassPageTest createState() => _ClassPageTest();
}

class ClassInfo {
  String name;
  String room;
  String time;
  String day;
  String image;
  String building;

  ClassInfo({
    required this.name,
    required this.room,
    required this.time,
    required this.day,
    required this.image,
    required this.building,
  });

  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    return ClassInfo(
      name: json['name'],
      room: json['room'],
      time: json['time'],
      day: json['day'],
      image: json['image'],
      building: json['building'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'room': room,
      'time': time,
      'day': day,
      'image': image,
      'building': building,
    };
  }
}

class _ClassPageTest extends State<ClassPageTest> {
  Future<SharedPreferences> _prefs = SharedPreferences
      .getInstance(); //makes the shared prefrences update when changed right away

  @override
  void initState() {
    //loads data on startup
    loadClasses();
    testPreferences();
    super.initState();
  }

  List<ClassInfo> classes = []; //create class list

  Color textColor =
      Color.fromARGB(255, 141, 185, 202); // avc blue text for the class cards

  //colors for testing things
  final Color avcorange = Color.fromARGB(255, 241, 138, 32); // avc orange
  final Color avcblue = Color.fromARGB(255, 141, 185, 202); // avc blue
  final Color avcgreen = Color.fromARGB(255, 0, 107, 103); // avc green
  final Color avcred = Color(0xFF8B1C3F);

  //default lat and lon for if the class does not have cords
  double latitudeClass1 = 34.67613026710341;
  double longitudeClass1 = -118.19203306356845;

  Map<String, String> imgmap = {
    'Select a class': '',
    'CSUB/CSU Bakersfield':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_bakersfield.jpg?raw=true',
    'DL/Discovery Lab': '',
    'AL/Auto Lab':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_autolab.jpg?raw=true',
    'UH/Uhazy Hall':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_uhazyhall.jpg?raw=true',
    'YH/Yoshida Hall':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_yoshidahall.jpg?raw=true',
    'S1-9/SOAR High School': '',
    'PA/Performing Arts Theatre': '',
    'FA1/Art Gallery':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_artgallery.jpg?raw=true',
    'FA2/Black Box':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_blackbox.jpg?raw=true',
    'MH/Mesquite Hall':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_mh.jpg?raw=true',
    'LH/Lecture Hall':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_lh.jpg?raw=true',
    'SH/Sage Hall':
        'https://www.avc.edu/sites/default/files/inline-images/nov2021-1.png?raw=true',
    'ME/Math and Engineering':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_me.jpg?raw=true',
    'FA4/Fine Arts':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_finearts.jpg?raw=true',
    'FA3/Fine Arts Music and Offices': '',
    'EL/Enterprise Lab':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_enterpriselab.jpg?raw=true',
    'HL/Horticulture Lab':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_horticulture.jpg?raw=true',
    'GH1-4/Greenhouses':
        'https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_greenhouse.jpg?raw=true',
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

  late String classforCords = ""; //used to match class name to cords
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Schedule')),
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          return _buildClassCard(classes[index], index);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Class'),
        icon: const Icon(Icons.add),
        onPressed: _addClass,
      ),
    );
  }

  Widget _buildClassCard(ClassInfo classInfo, int index) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: SizedBox(
          width: 150, // Set desired width
          height: 150, // Set desired height
          child: FadeInImage.assetNetwork(
            placeholder:
                'assets/images/default.png', // Default image while loading
            image: imgmap[classInfo.building].toString(), // Network image URL
            imageErrorBuilder: (context, error, stackTrace) {
              // Fallback to default image if the network image fails to load
              return Image.asset(
                'assets/images/default.png',
              );
            },
            fit: BoxFit.cover,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Name: ${classInfo.name}"),
            Text("Building: ${classInfo.building}"),
            Text("Room: ${classInfo.room}"),
            Text("Time: ${classInfo.time}"),
            Text("Day: ${classInfo.day}"),
            IconButton(
                onPressed: () => goPress(classInfo.building),
                icon: const Icon(Icons.map_rounded)),
          ],
        ),
        onTap: () => _editClass(classInfo, index),
      ),
    );
  }

  void _showClassDialog(ClassInfo classInfo, {int? index}) {
    final TextEditingController nameController =
        TextEditingController(text: classInfo.name);
    final TextEditingController roomController =
        TextEditingController(text: classInfo.room);
    final TextEditingController timeController =
        TextEditingController(text: classInfo.time);
    final TextEditingController dayController =
        TextEditingController(text: classInfo.day);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Adjust height for keyboard
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust to content height
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Draggable handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between handle and content
                Text(
                  index == null ? 'Add Class' : 'Edit Class',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                // Text fields and dropdown
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Class Name'),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: roomController,
                  decoration: InputDecoration(labelText: 'Room'),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: dayController,
                  decoration: InputDecoration(labelText: 'Day'),
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value:
                      classInfo.building.isNotEmpty ? classInfo.building : null,
                  decoration: InputDecoration(labelText: 'Building'),
                  items: classList.map((building) {
                    return DropdownMenuItem(
                      value: building,
                      child: Text(building),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      classInfo.building = newValue!;
                    });
                  },
                  hint: Text('Select a building'),
                ),
                SizedBox(height: 16.0),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (index != null)
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            classes.removeAt(index);
                          });
                          saveClasses();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                        label: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          classInfo.name = nameController.text;
                          classInfo.room = roomController.text;
                          classInfo.time = timeController.text;
                          classInfo.day = dayController.text;

                          if (index == null) {
                            classes.add(classInfo);
                          } else {
                            classes[index] = classInfo;
                          }
                        });
                        saveClasses();
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Add bottom padding
              ],
            ),
          ),
        );
      },
    );
  }

  void _editClass(ClassInfo classInfo, int index) {
    _showClassDialog(classInfo, index: index);
  }

  void _removeClass(int index) {
    setState(() {
      classes.removeAt(index);
    });
    saveClasses();
  }

  Future<void> saveClasses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> classList =
          classes.map((c) => jsonEncode(c.toJson())).toList();
      await prefs.setStringList('classes', classList);
      print('Classes saved: $classList'); // Log the saved classes
    } catch (e) {
      print('Error saving classes: $e');
    }
  }

  Future<void> loadClasses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? classList = prefs.getStringList('classes');
      if (classList != null) {
        setState(() {
          classes =
              classList.map((c) => ClassInfo.fromJson(jsonDecode(c))).toList();
        });
        print('Classes loaded: $classes'); // Log the loaded classes
      }
    } catch (e) {
      print('Error loading classes: $e');
    }
  }

  void _addClass() {
    final newClass = ClassInfo(
        name: '', room: '', time: '', day: '', image: '', building: '');
    _showClassDialog(newClass);
  }

  void clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.clear();
      prefs.setBool('ShowClass1', false);
    });
  }

  void goPress(String classselected) async {
    classforCords = classselected;
    //TO DO: set classforCords to = somehting
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyApp(
                latitude: latMap[classforCords],
                longitude: lonMap[classforCords],
                zoom: 19,
              )),
    );
  }
}

Future<void> testPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('testKey', 'testValue');
  print('Saved: ${prefs.getString('testKey')}');
}
