import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:location/location.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'src/locations.dart' as locations;
import 'src/help_page.dart';

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

  Set<Marker> markers = {};
  // Always contains all markers. Used for resetting markers
  Set<Marker> markersCopy = {};

  // Poly-lines
  Set<Polyline> _polylines = {};

  LocationData? currentLocation;
  LatLng? currentLocationLatLng;

  // Tool States
  bool _isSwitched = false;

  // Filter States
  bool parkingChecked = false;
  bool classroomsChecked = false;
  bool studentResourcesChecked = false;
  bool foodChecked = false;
  bool athleticsChecked = false;

  Future<void> _onMapCreated(GoogleMapController controller, BuildContext context) async {

    mapController = controller;
    markers = await locations.getMarkers(context);

    // After loading the markers, update the state of the map with setState
    setState(() {
      markers.addAll(markers);
      markersCopy.addAll(markers);
    });
  }

  // User Location Related
  void getCurrentLocation() async {
    Location location = Location();

    // Checks if location services and permissions are enabled
    checkServicesAndPermissions(location);

    currentLocation = await location.getLocation();

    // Gets location updates
    location.onLocationChanged.listen(
      (LocationData updatedLocation){
        currentLocation = updatedLocation;
        currentLocationLatLng = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      }
    );
  }

  void checkServicesAndPermissions(Location location) async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }


  @override
  void initState(){
    super.initState();
    getCurrentLocation();
  }

  void _filterMarkers() {
    int filterCount = 0;
    Set<Marker> tmp = {};
    if(parkingChecked) {
      tmp.addAll(locations.parkingLotMarkers);
      ++filterCount;
    }
    if(athleticsChecked) {
      tmp.addAll(locations.athleticMarkers);
      ++filterCount;
    }
    if(foodChecked) {
      tmp.addAll(locations.foodMarkers);
      ++filterCount;
    }
    if(studentResourcesChecked) {
      tmp.addAll(locations.resourceMarkers);
      ++filterCount;
    }
    if(classroomsChecked) {
      tmp.addAll(locations.classroomMarkers);
      ++filterCount;
    }

    if(filterCount > 0){
      markers = tmp;
    }
    else{
      markers = markersCopy;
    }
  }
  Marker? userMarker;
  void manageTap(LatLng latLng){
    if(_isSwitched){
      // Create user marker
      userMarker = Marker(
        markerId: MarkerId('user_marker'),
        position: latLng,
        infoWindow: InfoWindow(title: 'User Marker'),
      );
      // Add userMarker to the map
      setState(() {
        markers.add(userMarker!);
      });

      // Draw polyline from current location to userMarker
      drawRoute(latLng);
    }
  }

  // TODO: Create working routes based on google map data via directions API
  void drawRoute(LatLng latLng) async {
    LatLng start = currentLocationLatLng!;
    LatLng? end = latLng;
    final directions = DirectionsService();

    // PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylinePoints = [start, end];

    // PolylineResult result = await PolylineResult(
    //     polylinePoints.getRouteBetweenCoordinates("AIzaSyBcejXkg5ARzeVaXQbxq7-yy04g1ZsIOQE", PointLatLng(start.latitude, start.longitude), PointLatLng(end.latitude, end.longitude), travelMode: TravelMode.walking);
    // );
    Polyline polyline = Polyline(
      polylineId: PolylineId('polyline'),
      points: polylinePoints,
      color: Colors.blue,
      width: 5,
    );

   _polylines.add(polyline);

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
          )),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AVC Interactive Map',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Sans Serif',
              )),
          centerTitle: true,
          elevation: 2,
        ),
        drawer: Builder(
            builder: (context) => Drawer(
                child: ListView(padding: EdgeInsets.zero, children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                        color: Color(0xFF8B1C3F),
                        image: DecorationImage(
                          image: AssetImage('assets/images/image_avc_logo.png'),
                        )),
                    child: Text(''),
                  ),

                // General Buttons
                ListTile(
                  leading: const Icon(Icons.map_outlined),
                  title: const Text('Map'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HelpPage()),
                    );
                  },
                ),
                const Divider(),

                // Tools
                SwitchListTile(
                  title: const Text('Building Route'),
                  secondary: const Icon(Icons.near_me),
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;

                      if(_isSwitched){
                        // Ensure current location exists before using the feature
                        //checkServicesAndPermissions(currentLocation as Location);
                      }
                      // Remove marker if feature is turned off
                      if(!_isSwitched) {
                        // Removes all instances of user created markers
                        markers.removeWhere((userMarker) => userMarker.markerId == const MarkerId('user_marker'));
                        // Clears poly-lines
                        _polylines.clear();
                      }
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_parking),
                  title: const Text('Nearest Parking'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                const Divider(),

                // Filters
                CheckboxListTile(
                  title: const Text('Parking Lots'),
                  secondary: const Icon(Icons.car_repair_rounded),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: parkingChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      parkingChecked = value ?? false;
                    });
                    _filterMarkers();
                  },
                ),
                CheckboxListTile(
                  title: const Text('Classrooms'),
                  secondary: const Icon(Icons.book),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: classroomsChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      classroomsChecked = value ?? false;
                    });
                    _filterMarkers();
                  },
                ),
                CheckboxListTile(
                  title: const Text('Student Resources'),
                  secondary: const Icon(Icons.account_balance),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: studentResourcesChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      studentResourcesChecked = value ?? false;
                    });
                    _filterMarkers();
                  },
                ),
                CheckboxListTile(
                  title: const Text('Food'),
                  secondary: const Icon(Icons.food_bank),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: foodChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      foodChecked = value ?? false;
                    });
                    _filterMarkers();
                  },
                ),
                CheckboxListTile(
                  title: const Text('Athletics'),
                  secondary: const Icon(Icons.sports_tennis_rounded),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: athleticsChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      // Using a null-aware operator in case value is null
                      athleticsChecked = value ?? false;
                    });
                    _filterMarkers();
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
          markers: markers,
          myLocationEnabled: true,
          onTap: manageTap,
          polylines: _polylines,
          )
        ),
      ),
    );
  }
}
