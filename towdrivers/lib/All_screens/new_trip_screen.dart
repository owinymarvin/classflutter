import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newTripGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  //variables
  Set<Marker> setOffMarkers = Set<Marker>();
  Set<Circle> setOffCircles = Set<Circle>();
  Set<Polyline> setOffPolyline = Set<Polyline>();
  //list
  List<LatLng> polyLinePositionCoodinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double mapPadding = 0;
  BitmapDescriptor? iconAnimatedMarker;
  var geolocator = Geolocator();
  Position? onlineDriverCurrentPosition;
  String rideRequestStatus = "accepted";
  String durationFromOriginToDestination = "";
  bool isRequestDirectionDetails = false;

  @override
  Widget build(BuildContext context) {
    bool darktheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          //Google map
          GoogleMap(
              padding: EdgeInsets.only(bottom: mapPadding),
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: _kGooglePlex,
              markers: setOffMarkers,
              circles: setOffCircles,
              polylines: setOffPolyline,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newTripGoogleMapController = controller;
                setState(() {
                  mapPadding = 350;
                });
              }),
        ],
      ),
    );
  }
}
