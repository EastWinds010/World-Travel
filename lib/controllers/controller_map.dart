// ignore_for_file: unnecessary_new
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:learning_dart/service/service_login_user.dart';

class ControllerMap {
  //variáveis
  VoidCallback? func;
  MapController controllerMap = new MapController();
  ServiceLoginUser serciveLoginUser = new ServiceLoginUser();
  String tileLayers = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  List<String> domains = ['a', 'b', 'c'];
  List<Marker> markers = [];
  List<Marker> markersFinal = [];
  List<CircleMarker> circles = [];
  List<Polyline> polyline = [];
  double latitude = 0;
  double longitude = 0;
  double latitudeDestiny = 0.0;
  double longitudeDestiny = 0.0;
  String? displayName;
  String photoUrl = '';
  //actions

  Future<void> mapCreate() async {
    Geolocator.requestPermission();
    serciveLoginUser.getUsers().then((displayInfoUsers) async {
      displayName = displayInfoUsers['DATA']['name'];
      print(displayName);
      photoUrl = displayInfoUsers['DATA']['photoUrl'];
      print(photoUrl);
      func?.call();
    });
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await Geolocator.getCurrentPosition().then((result) {
        latitude = result.latitude;
        longitude = result.longitude;
        print("Latitude: ${result.latitude} Longitude: ${result.longitude}");
        controllerMap.move(
          LatLng(result.latitude, result.longitude),
          17,
        );
        markers.clear();
        markers.add(Marker(
            point: LatLng(result.latitude, result.longitude),
            builder: (ctx) => const Icon(
                  Icons.location_history,
                  color: Colors.black,
                  size: 30,
                )));
      }).catchError((res) => print(res));
      func?.call();
    }
  }

  void createRoute(LatLng latLng) {
    addCircleInMap(latLng);
    polinynes(latLng);
    addPolyInMap(latLng);
    navigateInMap(latitude, longitude);
  }

  void addCircleInMap(LatLng latLng) async {
    String distance = await Geolocator.distanceBetween(
            latitude, longitude, latLng.latitude, latLng.longitude)
        .toStringAsFixed(2);
    Fluttertoast.showToast(
        msg: 'Distância: $distance Metros',
        toastLength: Toast.LENGTH_LONG,
        fontSize: 25);
    circles.clear();
    circles.add(CircleMarker(
        point: latLng,
        radius: 60,
        color: Colors.black.withOpacity(0.2),
        borderColor: Colors.black,
        borderStrokeWidth: 1));
    func?.call();
  }

  Future<PolylineResult> polinynes(LatLng latLng) async {
    List<LatLng> points = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "GOOGLE KEY",
      PointLatLng(latLng.latitude, latLng.longitude),
      PointLatLng(latitudeDestiny, longitudeDestiny),
      travelMode: TravelMode.driving,
    );
    return result;
  }

  Future<void> addPolyInMap(LatLng latLng) async {
    latitudeDestiny = latLng.latitude;
    longitudeDestiny = latLng.longitude;
    List<LatLng> points = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "GOOGLE KEY",
      PointLatLng(latitude, longitude),
      PointLatLng(latitudeDestiny, longitudeDestiny),
      travelMode: TravelMode.driving,
    );
    for (var item in result.points) {
      points.add(LatLng(item.latitude, item.longitude));
      print("Latitude: ${item.latitude} Longitude: ${item.longitude}");
      polyline.add(Polyline(
        points: points,
        color: Colors.black,
        strokeWidth: 4.0,
        borderColor: Colors.black,
      ));
      markersFinal.clear();
      markersFinal.add(Marker(
          builder: (ctx) => const Icon(
                Icons.person,
                color: Colors.black,
                size: 30,
              ),
          point: LatLng(latLng.latitude, latLng.longitude)));
      func?.call();
    }
  }

  Future<void> navigateInMap(double lat, double lng) async {
    List<LatLng> points = [];
    PolylineResult result = await polinynes(LatLng(lat, lng));
    polyline.clear();
    func?.call();

    for (var item in result.points) {
      points.add(LatLng(item.latitude, item.longitude));
    }
    polyline.add(Polyline(points: points, color: Colors.red, strokeWidth: 4.0));
    double heading = SphericalUtils.computeHeading(
        Point(points[0].latitude, points[0].longitude),
        Point(points[1].latitude, points[1].longitude));
    controllerMap.rotate(heading * (-1));
    func?.call();
  }
}
