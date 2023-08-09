// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:appusers/widget/Divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Search_Screen.dart';
import 'login.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:provider/provider.dart';
// import 'package:uber_clone/DataHandler/appData.dart';
// import 'package:uber_clone/helper/apiMethod.dart';
// import 'package:uber_clone/models/directionDetails.dart';
// import 'package:uber_clone/screens/Auth/login.dart';

// import 'package:uber_clone/widget/progressdialog.dart';

// import '../screens/Auth/login.dart';

class MyHomePage extends StatefulWidget {
  static const String idScreen = "homepage";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  //global key
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

//setting up geoloaction
  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingofMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition =
        position; //get latitude and longitude of the user through the phone

    LatLng latlatPosition = LatLng(position.latitude, position.longitude);

//camera move according to your location
    CameraPosition cameraPosition =
        new CameraPosition(target: latlatPosition, zoom: 14);

    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // String address = await ApiMethods.seachCoordinateAddress(position, context);
    // print("this is Your address $address");
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldkey,
      // key: scaffoldkey,
      appBar: AppBar(
        title: Text("Home"),
      ),
//drawer styling
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  //top container with the user pic
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/user_icon.png',
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile Name",
                            style: TextStyle(
                                fontFamily: "Brand-Regular", fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text("Visit Profile"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              DividerWidget(),
              SizedBox(
                height: 12.0,
              ),
              //Drawer Body
              ListTile(
                leading: Icon(Icons.history),
                title: Text('History', style: TextStyle(fontSize: 15.0)),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Visit Profile', style: TextStyle(fontSize: 15.0)),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About', style: TextStyle(fontSize: 15.0)),
              ),

              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Logout', style: TextStyle(fontSize: 15.0)),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          GoogleMap(
            //padding to google map
            padding: EdgeInsets.only(bottom: bottomPaddingofMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            //my geo location enabled
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            //
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              //when map is created set state

              setState(() {
                bottomPaddingofMap = 300.0;
              });

              locatePosition();
            },
          ),

          //to open the drawer
          // Positioned(
          //   top: 45.0,
          //   left: 22.0,
          //   child: GestureDetector(
          //     onTap: () {
          //       scaffoldkey.currentState?.openDrawer();
          //     },
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(22.0),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black,
          //             blurRadius: 6.0,
          //             spreadRadius: 0.5,
          //             offset: Offset(
          //               0.7,
          //               0.7,
          //             ),
          //           ),
          //         ],
          //       ),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.white,
          //         child: Icon(
          //           Icons.menu,
          //           color: Colors.black,
          //         ),
          //         radius: 20.0,
          //       ),
          //     ),
          //   ),
          // ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
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

                    DividerWidget(),

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
