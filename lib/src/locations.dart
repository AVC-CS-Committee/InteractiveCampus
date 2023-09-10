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
      images.add('https://raw.githubusercontent.com/AVC-CS-Committee/InteractiveCampusMap/master/app/src/main/res/drawable/image_$image.jpg');
    }

    Marker marker = Marker(
      markerId: MarkerId(location.title),
      position: LatLng(location.latitude, location.longitude),
      infoWindow: InfoWindow(
        title: location.title,
        snippet: location.description,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LocationDescriptions(
              title: location.title,
              description: location.description, 
              images: images, 
              )),
          );
        }
      ),
    );
//test
    Marker marker_custom = Marker(
      markerId: MarkerId(location.title),
      position: LatLng(location.latitude, location.longitude),
      infoWindow: InfoWindow(
          title: location.title,
          snippet: location.description,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationDescriptions(
                title: location.title,
                description: location.description,
                images: images,
              )),
            );
          }
      ),
    );



    // Store the current marker into its corresponding List
    if (location.type == "parking") {
      parkingLotMarkers.add(marker);
    }
    if (location.type == "classroom") {
      classroomMarkers.add(marker);
    }
    if (location.type == "food") {
      foodMarkers.add(marker);
    }
    if (location.type == "athletic") {
      athleticMarkers.add(marker);
    }
    if (location.type == "resource") {
      resourceMarkers.add(marker);
    }

    markers.add(marker);
  }

  return markers;
}
