import 'dart:async';
import 'package:firstpro/home_contents/Search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../features/map_divider.dart';

class UserTowServices extends StatefulWidget {
  const UserTowServices({super.key});

  @override
  State<UserTowServices> createState() => _UserTowServicesState();
}

class _UserTowServicesState extends State<UserTowServices> {
  //completer code
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0.3326, 32.5686),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 315.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 23.0, vertical: 17.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      'hey there',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Where are you?',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),

                    //sized box
                    SizedBox(
                      height: 20.0,
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Search near by tow services")
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 24.0,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add location'),
                            SizedBox(height: 4.0),
                            Text(
                              "Address",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    MapDivider(),

                    SizedBox(height: 16.0),

                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Destination'),
                            SizedBox(height: 4.0),
                            Text(
                              "Towing it to",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
