import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

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

Future<Set<Marker>> getMarkers() async {
  String jsonString = await rootBundle.loadString('assets/json/locations.json');
  List<dynamic> jsonList = json.decode(jsonString);

  Set<Marker> markers = {};

  for (var jsonData in jsonList) {
    Locations location = Locations.fromJson(jsonData);
    Marker marker = Marker(
      markerId: MarkerId(location.title),
      position: LatLng(location.latitude, location.longitude),
      infoWindow: InfoWindow(
        title: location.title,
        snippet: location.description,
      ),
    );

    markers.add(marker);
  }

  return markers;
}
