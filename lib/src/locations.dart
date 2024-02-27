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
import 'package:image/image.dart';


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

Future<void> getMarkers(BuildContext context) async {
  String jsonString = await rootBundle.loadString('assets/json/locations.json');
  List<dynamic> jsonList = json.decode(jsonString);

  parkingLotMarkers.clear();
  classroomMarkers.clear();
  foodMarkers.clear();
  athleticMarkers.clear();
  resourceMarkers.clear();

  double iconSize = MediaQuery.of(context).size.width * 0.15;

  for (var jsonData in jsonList) {
    Locations location = Locations.fromJson(jsonData);
    String assetPath = _getAssetPath(location.type);
    BitmapDescriptor markerIcon = await createCustomMarkerIcon(context, assetPath, iconSize);
    
    List<String> images = [];
    if (location.images.isEmpty) images.add('');
    for (String image in location.images) {images.add('https://raw.githubusercontent.com/AVC-CS-Committee/InteractiveCampusMap/master/app/src/main/res/drawable/image_$image.jpg');}

    Marker marker = Marker(
      markerId: MarkerId(location.title),
      position: LatLng(location.latitude, location.longitude),
      icon: markerIcon,
      infoWindow: InfoWindow(
          title: location.title,
          snippet: "Click for more info.",
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

    switch (location.type) {
      case "parking":
        parkingLotMarkers.add(marker);
        break;
      case "classroom":
        classroomMarkers.add(marker);
        break;
      case "food":
        foodMarkers.add(marker);
        break;
      case "athletic":
        athleticMarkers.add(marker);
        break;
      case "resource":
        resourceMarkers.add(marker);
        break;
      // Include a default case or other types if necessary
    }
  }
}

String _getAssetPath(String type) {
  switch (type) {
    case "parking":
      return 'assets/images/parking.png';
    case "classroom":
      return 'assets/images/classroom.png';
    case "food":
      return 'assets/images/food.png';
    case "athletic":
      return 'assets/images/athletics.png';
    case "resource":
      return 'assets/images/resources.png';
    default:
      return 'assets/images/default_marker.png';
  }
}

Future<BitmapDescriptor> createCustomMarkerIcon(BuildContext context, String assetPath, double iconSize) async {
  final ByteData? byteData = await rootBundle.load(assetPath);

  if (byteData == null) {
    throw FlutterError('Failed to load asset: $assetPath');
  }

  final Uint8List uint8List = byteData.buffer.asUint8List();
  final img.Image? image = img.decodeImage(uint8List);
  if (image == null) {
    throw FlutterError('Failed to decode image');
  }

  final img.Image rgbaImage = img.copyRotate(image, 0); // Ensure it's not rotated
  final Uint8List rgbaUint8List = Uint8List.fromList(img.encodePng(rgbaImage));
  //final img.Image rgbaImage = img.copyRotate(resizedImage, 0);
  //final Uint8List rgbaUint8List = Uint8List.fromList(img.encodePng(rgbaImage));

  return BitmapDescriptor.fromBytes(rgbaUint8List);
}