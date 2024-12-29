import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:interactivemap/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class BuildingInfo {
  late final String name;
  late final double latitude;
  late final double longitude;
  late final String imageURL;

  BuildingInfo({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.imageURL,
  });
}

class _ClassPageTest extends State<ClassPageTest> {
  Future<SharedPreferences> _prefs = SharedPreferences
      .getInstance(); //makes the shared prefrences update when changed right away

  @override
  void initState() {
    //loads data on startup
    loadClasses();
    //testPreferences();
    super.initState();
  }

  List<ClassInfo> classes = []; //create class list

  // avc blue text for the class cards
  Color textColor = const Color.fromARGB(255, 141, 185, 202);

  //colors for testing things
  final Color avcorange = const Color.fromARGB(255, 241, 138, 32); // avc orange
  final Color avcblue = const Color.fromARGB(255, 141, 185, 202); // avc blue
  final Color avcgreen = const Color.fromARGB(255, 0, 107, 103); // avc green
  final Color avcred = const Color(0xFF8B1C3F);

  //default lat and lon for if the class does not have cords
  double latitudeClass1 = 34.67613026710341;
  double longitudeClass1 = -118.19203306356845;

  //list of all the buildings with cords and image urls, when addiumg a new building add it here
  //made sure to add the building to the classList as well if you add a new building
  //On how to use the info look in the goPress function or getURL function
  //TO DO: Add more image URLS for the buildings on github then add link here
  final List<BuildingInfo> buildinginfoList = [
    BuildingInfo(
      name: 'Select a class',
      latitude: 34.67613026710341,
      longitude: -118.19203306356845,
      imageURL: "",
    ),
    BuildingInfo(
      name: 'CSUB/CSU Bakersfield',
      latitude: 34.680353586506165,
      longitude: -118.18506976951421,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_bakersfield.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'DL/Discovery Lab',
      latitude: 34.680452828358916,
      longitude: -118.18656003661856,
      imageURL: "",
    ),
    BuildingInfo(
      name: 'AL/Auto Lab',
      latitude: 34.67882218077683,
      longitude: -118.18719722438767,
      imageURL:
          "https://raw.githubusercontent.com/AVC-CS-Committee/InteractiveCampusMap/refs/heads/master/app/src/main/res/drawable/image_autolab.jpg",
    ),
    BuildingInfo(
      name: 'UH/Uhazy Hall',
      latitude: 34.6788359665366,
      longitude: -118.18640225876932,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_uhazyhall.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'YH/Yoshida Hall',
      latitude: 34.67899187744454,
      longitude: -118.18548358738202,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_yoshidahall.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'S1-9/SOAR High School',
      latitude: 34.67877310935158,
      longitude: -118.18800679457378,
      imageURL: "",
    ),
    BuildingInfo(
      name: 'PA/Performing Arts Theatre',
      latitude: 34.6754613377245,
      longitude: -118.18723230937766,
      imageURL: "",
    ),
    BuildingInfo(
      name: 'FA1/Art Gallery',
      latitude: 34.676203764577544,
      longitude: -118.18697930907051,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_artgallery.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'FA2/Black Box',
      latitude: 34.675832701065104,
      longitude: -118.18737862660834,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_blackbox.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'MH/Mesquite Hall',
      latitude: 34.67687342944362,
      longitude: -118.18512883579885,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_mh.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'LH/Lecture Hall',
      latitude: 34.677011511466674,
      longitude: -118.18741261041862,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_lh.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'SH/Sage Hall',
      latitude: 34.67714651488922,
      longitude: -118.18709120662562,
      imageURL:
          "https://www.avc.edu/sites/default/files/inline-images/nov2021-1.png?raw=true",
    ),
    BuildingInfo(
      name: 'ME/Math and Engineering',
      latitude: 34.67775573632852,
      longitude: -118.18589961736947,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_me.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'FA4/Fine Arts',
      latitude: 34.67648676160919,
      longitude: -118.18738628333938,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_finearts.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'FA3/Fine Arts Music and Offices',
      latitude: 34.67626532974614,
      longitude: -118.18770778514867,
      imageURL: "",
    ),
    BuildingInfo(
      name: 'EL/Enterprise Lab',
      latitude: 34.67973186506707,
      longitude: -118.18654794631942,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_enterpriselab.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'HL/Horticulture Lab',
      latitude: 34.679898891625314,
      longitude: -118.1870825677824,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_horticulture.jpg?raw=true",
    ),
    BuildingInfo(
      name: 'GH1-4/Greenhouses',
      latitude: 34.679813863502766,
      longitude: -118.18775289064219,
      imageURL:
          "https://github.com/AVC-CS-Committee/InteractiveCampusMap/blob/master/app/src/main/res/drawable/image_greenhouse.jpg?raw=true",
    ),
  ];

  //TO DO: Remove the need for ClasList and just use the buildinginfoList------
  //This is still used for the dropdown menu so add new buildings here
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
    return GestureDetector(
      onTap: () => _editClass(classInfo, index), // allows tap to edit
      child: Card(
        color: avcred,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0), // Rounded top edges
              ),
              child: SizedBox(
                width: double.infinity,
                height: 200, // Fixed image height
                child: FadeInImage.assetNetwork(
                  placeholder:
                      'assets/images/default.png', // default img when loading network img
                  image: getURL(classInfo.building),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/default.png',
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(classInfo.building,
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black)),
                  const Divider(
                    thickness: 2,
                    color: Color.fromARGB(255, 141, 185, 202),
                  ),
                  Row(
                    children: [
                      Text("    Class Name: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: textColor,
                          )),
                      Text(classInfo.name,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("    Room: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: textColor,
                          )),
                      Text(classInfo.room,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("    Time: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: textColor,
                          )),
                      Text(classInfo.time,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("    Days: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: textColor,
                          )),
                      Text(classInfo.day,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ],
                  ),
                  IconButton(
                    onPressed: () => goPress(classInfo.building),
                    icon: const Icon(Icons.map_rounded,
                        color: Color.fromARGB(255, 141, 185, 202)),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      shape: const RoundedRectangleBorder(
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
                const SizedBox(height: 20), // Space between handle and content
                Text(
                  index == null ? 'Add Class' : 'Edit Class',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                // Text fields and dropdown
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Class Name'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: roomController,
                  decoration: const InputDecoration(labelText: 'Room'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: 'Time'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: dayController,
                  decoration: const InputDecoration(labelText: 'Day'),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value:
                      classInfo.building.isNotEmpty ? classInfo.building : null,
                  decoration: const InputDecoration(labelText: 'Building'),
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
                  hint: const Text('Select a building'),
                  menuMaxHeight: 250, // Limit dropdown height
                ),
                const SizedBox(height: 16.0),
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
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    const Spacer(),
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
                      child: const Text('Save'),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Add bottom padding
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

  Future<void> saveClasses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> classList =
          classes.map((c) => jsonEncode(c.toJson())).toList();
      await prefs.setStringList('classes', classList);
      //print('Classes saved: $classList');
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
        //print('Classes loaded: $classes'); // prints the loaded classes for testing
      }
    } catch (e) {
      print('Error loading classes: $e'); // prints error if classes do not load
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
    //gets the bulding info for the selected class returns default cords if not found
    //this can be reused for other buttons that need to go to a location or image URL
    //just use selectedclass.latitude or selectedclass.longitude or selectedclass.imageURL
    final selectedclass = buildinginfoList.firstWhere(
      (BuildingInfo) => BuildingInfo.name == classselected,
      orElse: () => BuildingInfo(
        name: 'Select a class',
        latitude: 34.67613026710341,
        longitude: -118.19203306356845,
        imageURL: "",
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyApp(
                latitude: selectedclass.latitude,
                longitude: selectedclass.longitude,
                zoom: 19,
              )),
    );
  }

  //used to get img url for the selected class
  String getURL(String classselected) {
    //gets the bulding info for the selected class returns default cords if not found
    //this can be reused for other buttons that need to go to a location or image URL
    //just use selectedclass.latitude or selectedclass.longitude or selectedclass.imageURL
    final selectedclass = buildinginfoList.firstWhere(
      (BuildingInfo) => BuildingInfo.name == classselected,
      orElse: () => BuildingInfo(
        name: 'Select a class',
        latitude: 34.67613026710341,
        longitude: -118.19203306356845,
        imageURL: "",
      ),
    );
    //print("url: " + selectedclass.imageURL);
    return selectedclass.imageURL;
  }
}

//used to test shared preferences
// Future<void> testPreferences() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('testKey', 'testValue');
//   print('Saved: ${prefs.getString('testKey')}');
// }
