import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning_dart/controllers/controller_logout.dart';
import 'package:learning_dart/controllers/controller_map.dart';
import 'package:learning_dart/service/service_login_user.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  ControllerMap controllerMap = ControllerMap();
  ServiceLoginUser serviceLoginUser = ServiceLoginUser();
  Logout logout = Logout();
  StreamSubscription<Position>? listenPosition;
  void updatedState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controllerMap.mapCreate();
    controllerMap.func = updatedState;
    Future.delayed(Duration(minutes: 10), () {
      listenCoordinates();

    });
  }

  void listenCoordinates() {
    listenPosition = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                distanceFilter: 0,
                accuracy: LocationAccuracy.best,
                timeLimit: Duration(seconds: 10)))
        .listen((event) {
      print('localização alterada');
      if (controllerMap.latitudeDestiny != 0.0 ||
          controllerMap.longitude != 0.0) {
        controllerMap.navigateInMap(event.latitude, event.longitude);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return controllerMap.displayName == null
        ? Center(
          child: SizedBox(
            width: size.width*0.5,
            height: size.width*0.5,
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 4,
              backgroundColor: Colors.white,
            ),
          ),
        )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Welcome ${controllerMap.displayName}'),
                  GestureDetector(
                    onTap: () {
                      logout.logout(context);
                    },
                    child: Container(
                      width: size.width * 0.13,
                      height: size.width * 0.13,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return controllerMap.photoUrl == null
                      ? Container(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ClipOval(
                              child: Image(
                            image: NetworkImage(controllerMap.photoUrl),
                            width: 10,
                            height: 10,
                            fit: BoxFit.cover,
                          )),
                        );

                  // CircleAvatar(child: Image.network(controllerMap.photoUrl));
                },
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.width * .03),
                  child: Center(
                    child: SizedBox(
                      width: size.width * .95,
                      height: size.height * .8,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius:
                                BorderRadius.circular(size.width * .1)),
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.width * .1),
                            child: FlutterMap(
                              options: MapOptions(
                                  center: LatLng(-19.912998, -43.940933),
                                  zoom: 13,
                                  controller: controllerMap.controllerMap,
                                  onMapCreated: ((e) =>
                                      controllerMap.mapCreate()),
                                  onTap: (tapPosition, latLng) =>
                                      controllerMap.createRoute(latLng)),
                              mapController: controllerMap.controllerMap,
                              layers: [
                                TileLayerOptions(
                                  urlTemplate: controllerMap.tileLayers,
                                  subdomains: controllerMap.domains,
                                ),
                                MarkerLayerOptions(
                                    markers: controllerMap.markers),
                                MarkerLayerOptions(
                                    markers: controllerMap.markersFinal),
                                CircleLayerOptions(
                                    circles: controllerMap.circles),
                                PolylineLayerOptions(
                                    polylineCulling: true,
                                    polylines: controllerMap.polyline)
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: size.width * .13,
                                height: size.width * .13,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100)),
                                child: GestureDetector(
                                  onTap: () {
                                    controllerMap.mapCreate();
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.gps_fixed,
                                    color: Colors.white,
                                    size: size.width * .1,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * .05),
                  child: Image.asset('assets/images/logo_black.png'),
                )
              ],
            ),
          );
  }
}
