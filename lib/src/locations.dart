import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_descriptions.dart';

part 'locations.g.dart';

Set<Marker> parkingLotMarkers = {};
Set<Marker> classroomMarkers = {};
Set<Marker> foodMarkers = {};
Set<Marker> athleticMarkers = {};
Set<Marker> resourceMarkers = {};

@JsonSerializable()
class Locations {
  final String title;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> images;
  final String type;

  Locations({
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.images,
    required this.type,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}

Future<String> getLocations() async {
  return await rootBundle.loadString('assets/json/locations.json');
}

Future<Set<Marker>> getMarkers(BuildContext context) async {
  String jsonString = await rootBundle.loadString('assets/json/locations.json');
  List<dynamic> jsonList = json.decode(jsonString);

  Set<Marker> markers = {};

  for (var jsonData in jsonList) {
    Locations location = Locations.fromJson(jsonData);
    List<String> images = [];

    if (location.images.isEmpty) images.add('');

    for (String image in location.images) {
      images.add(
          'https://raw.githubusercontent.com/AVC-CS-Committee/InteractiveCampusMap/master/app/src/main/res/drawable/image_$image.jpg');
    }


Future<BitmapDescriptor> createCustomMarkerIcon(BuildContext context, String assetPath, double iconSize) async {
  final ByteData? byteData = await rootBundle.load(assetPath);

  if (byteData == null) {
    throw FlutterError('Failed to load asset: $assetPath');
  }

  final Uint8List uint8List = byteData.buffer.asUint8List();

  // Load the image using the image package
  final img.Image? image = img.decodeImage(uint8List);

  if (image == null) {
    throw FlutterError('Failed to decode image');
  }

  // Convert the image to RGBA
  final img.Image rgbaImage = img.copyRotate(image, 0); // Ensure it's not rotated
  final Uint8List rgbaUint8List = Uint8List.fromList(img.encodePng(rgbaImage));

  return BitmapDescriptor.fromBytes(rgbaUint8List);
}



    BitmapDescriptor markerIcon;

     // Set custom marker icon based on location type
    if (location.type == "parking") {

      double iconSize = MediaQuery.of(context).size.width * 0.05; // Calculate the desired icon size
      markerIcon = await createCustomMarkerIcon(context, 'assets/images/parking.png', iconSize);

    } else if (location.type == "classroom") {
      double iconSize = MediaQuery.of(context).size.width * 0.05; // Calculate the desired icon size
      markerIcon = await createCustomMarkerIcon(context, 'assets/images/classroom.png', iconSize);
    } else if (location.type == "food") {
      double iconSize = MediaQuery.of(context).size.width * 0.05; // Calculate the desired icon size
      markerIcon = await createCustomMarkerIcon(context, 'assets/images/food.png', iconSize);
    } else if (location.type == "athletic") {
      double iconSize = MediaQuery.of(context).size.width * 0.05; // Calculate the desired icon size
      markerIcon = await createCustomMarkerIcon(context, 'assets/images/athletics.png', iconSize);
    } else if (location.type == "resource") {
      double iconSize = MediaQuery.of(context).size.width * 0.05; // Calculate the desired icon size
      markerIcon = await createCustomMarkerIcon(context, 'assets/images/resources.png', iconSize);
    } else {
      markerIcon = BitmapDescriptor.defaultMarker;
    }
    Marker marker = Marker(
      markerId: MarkerId(location.title),
      position: LatLng(location.latitude, location.longitude),
      icon: markerIcon, // Set the custom marker icon
      infoWindow: InfoWindow(
          title: location.title,
          snippet: location.description,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LocationDescriptions(
                        title: location.title,
                        description: location.description,
                        images: images,
                      )),
            );
          }),
    );

    markers.add(marker);
  }

  return markers;
}
