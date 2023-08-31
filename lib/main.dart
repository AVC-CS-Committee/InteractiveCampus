import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:location/location.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_maps_routes/google_maps_routes.dart';
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
  // MapsRoutes route = MapsRoutes();

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

  Future<void> _onMapCreated(
      GoogleMapController controller, BuildContext context) async {
    mapController = controller;
    markers = await locations.getMarkers(context);
    _getParkedLocation();

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
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void _filterMarkers() {
    int filterCount = 0;
    Set<Marker> tmp = {};
    if (parkingChecked) {
      tmp.addAll(locations.parkingLotMarkers);
      ++filterCount;
    }
    if (athleticsChecked) {
      tmp.addAll(locations.athleticMarkers);
      ++filterCount;
    }
    if (foodChecked) {
      tmp.addAll(locations.foodMarkers);
      ++filterCount;
    }
    if (studentResourcesChecked) {
      tmp.addAll(locations.resourceMarkers);
      ++filterCount;
    }
    if (classroomsChecked) {
      tmp.addAll(locations.classroomMarkers);
      ++filterCount;
    }

    if (filterCount > 0) {
      markers = tmp;
    } else {
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


    // IMPORTANT NOTE: This piece of code works by showing routes based on google map data. However, the routes only seem to
    //                 be displayed if the current account holder's API key has both the Directions API and billing enabled on
    //                 their google cloud console account.
     List<LatLng> polylinePoints = [start, end];
    // await route.drawRoute(polylinePoints, "classroom_path", Colors.lightBlueAccent, "AIzaSyBIKlTv4QecJ3oboGtCmPTFGQ-tgL1VUZU");
    // _polylines = route.routes;
    // DistanceCalculator distanceCalculator = DistanceCalculator();

    // Temporarily being used until routes are figured out
    Polyline polyline = Polyline(
      polylineId: PolylineId('polyline'),
      points: polylinePoints,
      color: Colors.blue,
      width: 5,
    );

   _polylines.add(polyline);

  }

  Marker? savedParkingMarker;
  void saveParking() {
    if(savedParkingMarker == null) {
      markers.removeWhere((userMarker) => userMarker.markerId == const MarkerId('parking_marker'));
    }
    savedParkingMarker = Marker(
      markerId: MarkerId('parking_marker'),
      position: currentLocationLatLng!,
      infoWindow: InfoWindow(title: 'You parked here'),
    );
    // Add savedParkingMarker to the map

    setState(() {
      markers.add(savedParkingMarker!);
    });

    _saveParkedLocation();
  }

  Future<void> _getParkedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitude = prefs.getDouble('parked_latitude');
    double? longitude = prefs.getDouble('parked_longitude');
    log('Retrieved parked location: ($latitude, $longitude)');
    if (latitude != null && longitude != null) {
      setState(() {
        savedParkingMarker = Marker(
          markerId: MarkerId('parking_marker'),
          position: LatLng(latitude, longitude),
        );
        markers.add(savedParkingMarker!);
        log("Length: ${markers.length}");
      });
    }
  }

  Future<void> _saveParkedLocation() async {
    if (savedParkingMarker != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('parked_latitude', savedParkingMarker!.position.latitude);
      prefs.setDouble('parked_longitude', savedParkingMarker!.position.longitude);
    }
  }

  Future<void> _removeParkedLocation() async {
    if (savedParkingMarker != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('parked_latitude');
      await prefs.remove('parked_longitude');
      setState(() {
        savedParkingMarker = null;
      });
    }
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
          iconTheme: const IconThemeData(color: Colors.white),
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
                        MaterialPageRoute(
                            builder: (context) => const HelpPage()),
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
                  leading: Icon(Icons.local_parking),
                  title: markers.contains(savedParkingMarker) ? Text('Delete Parking') : Text('Save Parking'),
                  textColor: markers.contains(savedParkingMarker) ? Colors.redAccent : null,
                  iconColor: markers.contains(savedParkingMarker) ? Colors.redAccent : null,
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    // True if user intends to delete marker
                    if(markers.contains(savedParkingMarker)) {
                      _removeParkedLocation();
                      markers.removeWhere((savedParkingMarker) => savedParkingMarker.markerId == const MarkerId('parking_marker'));
                    }
                    // Entered if user intends to save marker
                    else {
                      saveParking();
                    }
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
                ]))),
        body: Builder(
          builder: (context) => GoogleMap(
          onMapCreated: (controller) => _onMapCreated(controller, context),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 17.0,
          ),
          cameraTargetBounds:CameraTargetBounds(LatLngBounds(
              northeast:LatLng(34.680987, -118.185444) ,
              southwest:LatLng(34.675965, -118.191282)
            )
          ),


          markers: markers,
          myLocationEnabled: true,
          mapType: MapType.normal,
          onTap: manageTap,
          polylines: _polylines,
          )
        ),
      ),
    );
  }
}
