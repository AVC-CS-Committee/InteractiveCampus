import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

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

    BitmapDescriptor markerIcon;

    // Set custom marker icon based on location type
    if (location.type == "parking") {
      markerIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5),
          'assets/images/Image.png');
    } else if (location.type == "classroom") {
      markerIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    } else if (location.type == "food") {
      markerIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    } else if (location.type == "athletic") {
      markerIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    } else if (location.type == "resource") {
      markerIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
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
