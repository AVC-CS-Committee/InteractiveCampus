import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_config/flutter_config.dart';
import 'src/locations.dart' as locations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(34.678652329599096, -118.18616290156892);
  Set<Marker> _markers = {};

  // Tool States
  bool _isSwitched = false;

  // Filter States
  bool _parking_checked = false;
  bool _classrooms_checked = false;
  bool _student_resources_checked = false;
  bool _food_checked = false;
  bool _athletics_checked = false;



  Future<void> _onMapCreated(GoogleMapController controller, BuildContext context) async {
    mapController = controller;

    _markers = await locations.getMarkers(context);

    // After loading the markers, update the state of the map with setState
    setState(() {
      _markers.addAll(_markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff8d1c40),
          primary: const Color(0xff8d1c40),
          secondary: const Color(0xff8a1c40),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xff8a1c40),
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AVC Interactive Map', style: TextStyle(
            color: Colors.white,
            fontFamily: 'Sans Serif',
            )
          ),
          centerTitle: true,
          elevation: 2,
        ),
        drawer: Builder(
            builder: (context) => Drawer(
            child: ListView (
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF8B1C3F),
                    image: DecorationImage(
                        image: AssetImage('assets/images/image_avc_logo.png'),
                    )
                  ),
                  child: Text(''),
                ),

                // General Buttons
                ListTile(
                  leading: Icon(Icons.map_outlined),
                  title: const Text('Map'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: const Text('Help'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                Divider(),

                // Tools
                SwitchListTile(
                  title: const Text('Locations Near Me'),
                  secondary: Icon(Icons.near_me),
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.local_parking),
                  title: const Text('Nearest Parking'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                Divider(),

                // Filters
                CheckboxListTile(
                  title: Text('Parking Lots'),
                  secondary: Icon(Icons.car_repair_rounded),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: _parking_checked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      _parking_checked = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Classrooms'),
                  secondary: Icon(Icons.book),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: _classrooms_checked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      _classrooms_checked = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Student Resources'),
                  secondary: Icon(Icons.account_balance),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: _student_resources_checked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      _student_resources_checked = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Food'),
                  secondary: Icon(Icons.food_bank),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: _food_checked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      _food_checked = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Athletics'),
                  secondary: Icon(Icons.sports_tennis_rounded),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: _athletics_checked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      _athletics_checked = value ?? false;
                    });
                  },
                ),
              ]
            )
            )
        ),
        body: Builder(
          builder: (context) => GoogleMap(
          onMapCreated: (controller) => _onMapCreated(controller, context),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 17.0,
          ),
          markers: _markers,
          )
        ),
      ),
    );
  }
}