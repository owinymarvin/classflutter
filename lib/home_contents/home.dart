// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps/google_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserHome extends StatefulWidget {
  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(0.3326, 32.5686);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        elevation: 2,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 424,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
                tilt: 0,
                bearing: 0,
              ),
              // markers: _markers.values.toSet(),
              mapType: MapType.normal,
            ),
          ),
        ],
      ),
    );
  }
}
