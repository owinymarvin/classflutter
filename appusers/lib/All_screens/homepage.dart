import 'dart:async';
// import 'dart:js_interop';
import 'package:appusers/All_screens/Search_Places.dart';
import 'package:appusers/All_screens/precise_pickupLocation.dart';
import 'package:appusers/Assistant/assistant_methods.dart';
import 'package:appusers/Assistant/geofire_assistant.dart';
import 'package:appusers/global/global.dart';
// import 'package:appusers/global/map_key.dart';
import 'package:appusers/info_handler/app_info.dart';
import 'package:appusers/model/active_nearby_available_drivers.dart';
import 'package:appusers/widgets/progressdialog.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// import '../model/directions.dart';
import 'drawer_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LatLng? pickLocation;
  loc.Location location = loc.Location();
  String? _address;

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  //global key
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  double searchLocationContainerHeight = 220;
  double waitingResponsefromDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  Position? userCurrentPosition;
  var geolocation = Geolocator();

  LocationPermission? _locationPermission;
  double bottomPaddingofMap = 0;

  List<LatLng> pLineCoordinatedList = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};

  Set<Circle> circlesSet = {};

  String userName = '';

  String userEmail = '';

  bool openNavigationDrawer = true;

  bool activeNearbyDriverKeysLoaded = false;

  BitmapDescriptor? activeNearbyIcon;

  //Locate user position
  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 15);

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    //after picking location
    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCoordinates(
            userCurrentPosition!, context);
    print("This is our Address = " + humanReadableAddress);

//fetch user details
    userName = userModelCurrentinfo!.name!;
    userEmail = userModelCurrentinfo!.email!;

    intializeGeoFireListener();
    // AssistantMethods.readTripkeysForOnlineUser(context);
  }

  intializeGeoFireListener() {
    Geofire.initialize("activeDrivers");
    Geofire.queryAtLocation(
            userCurrentPosition!.latitude, userCurrentPosition!.longitude, 10)!
        .listen((map) {
      print(map);
      if (map != null) {
        var callback = map["callback"];
        switch (callback) {
          //if anydriver comes active or online
          case Geofire.onKeyEntered:
            ActiveNearByAvailableDrivers activeNearByAvailableDrivers =
                ActiveNearByAvailableDrivers();
            activeNearByAvailableDrivers.locationLatitude = map["latitude"];
            activeNearByAvailableDrivers.locationLongitude = map["longitude"];
            activeNearByAvailableDrivers.driverId = map["key"];
            GeofireAssistant.ActiveNearByAvailableDriversList.add(
                activeNearByAvailableDrivers);
            if (activeNearbyDriverKeysLoaded == true) {
              displayActiveDriversOnUsersMap();
            }
            break;
          //whenever any driver become non active/online
          case Geofire.onKeyExited:
            GeofireAssistant.deleteOfflineDriverFromList(map["key"]);
            displayActiveDriversOnUsersMap();
            break;
          //if a drive moves update driver location
          case Geofire.onKeyMoved:
            ActiveNearByAvailableDrivers activeNearByAvailableDrivers =
                ActiveNearByAvailableDrivers();
            activeNearByAvailableDrivers.locationLatitude = map["latitude"];
            activeNearByAvailableDrivers.locationLongitude = map["longitude"];
            activeNearByAvailableDrivers.driverId = map["key"];
            GeofireAssistant.updateActiveNearByAvailableDriverLocation(
                activeNearByAvailableDrivers);
            displayActiveDriversOnUsersMap();
            break;

          //display those active online drivers on users map
          case Geofire.onGeoQueryReady:
            activeNearbyDriverKeysLoaded = true;
            displayActiveDriversOnUsersMap();
            break;
        }
      }
      setState(() {});
    });
  }

//function
  displayActiveDriversOnUsersMap() {
    setState(() {
      markersSet.clear();
      circlesSet.clear();

      Set<Marker> driversMarkerSet = Set<Marker>();
      for (ActiveNearByAvailableDrivers eachDriver
          in GeofireAssistant.ActiveNearByAvailableDriversList) {
        LatLng eachDriverActivePosition =
            LatLng(eachDriver.locationLatitude!, eachDriver.locationLongitude!);

        Marker marker = Marker(
          markerId: MarkerId(eachDriver.driverId!),
          position: eachDriverActivePosition,
          icon: activeNearbyIcon!,
          rotation: 360,
        );
        driversMarkerSet.add(marker);
      }
      setState(() {
        markersSet = driversMarkerSet;
      });
    });
  }

//create active nearby
  createActiveNearByDriverIconMarker() {
    if (activeNearbyIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(0.2, 0.2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/images/pickicon.png')
          .then((value) {
        activeNearbyIcon = value;
      });
    }
  }

  //drawing polylines on map
  Future<void> drwaPolylineFromOriginToDestination(bool darktheme) async {
    //for our pickup location
    var originPosition =
        Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
//for our destination
    var destinationPosition =
        Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

    //for latlng
    var originLatLng = LatLng(
        originPosition!.locationLatitude!, originPosition.locationLongitude!);

    var destinationLatLng = LatLng(destinationPosition!.locationLatitude!,
        destinationPosition.locationLongitude!);

    //show a dialogue
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Please wait...",
      ),
    );
    var directionDetailsInfo =
        await AssistantMethods.obtainOriginToDestinationDirectionsDetails(
            originLatLng, destinationLatLng);

    setState(() {
      tripDirectionDetailsInfo = directionDetailsInfo;
    });
//pop context
    Navigator.pop(context);

    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodePolyLinePointsResultsList =
        pPoints.decodePolyline(directionDetailsInfo.e_points!);
    pLineCoordinatedList.clear();

    if (decodePolyLinePointsResultsList.isNotEmpty) {
      decodePolyLinePointsResultsList.forEach((PointLatLng pointLatLng) {
        pLineCoordinatedList
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    //set plyline state
    setState(() {
      Polyline polyline = Polyline(
        color: darktheme ? Colors.amberAccent : Colors.blue,
        polylineId: PolylineId("PolyLineID"),
        jointType: JointType.round,
        points: pLineCoordinatedList,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
        width: 5,
      );
//add polyline
      polylineSet.add(polyline);
    });

    //add markers and circles
    LatLngBounds boundslatlng;
    if (originLatLng.latitude > destinationLatLng.latitude &&
        originLatLng.longitude > destinationLatLng.longitude) {
      boundslatlng =
          LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
    } else if (originLatLng.longitude > destinationLatLng.longitude) {
      boundslatlng = LatLngBounds(
        southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
        northeast: LatLng(destinationLatLng.latitude, originLatLng.longitude),
      );
    } else if (originLatLng.latitude > destinationLatLng.latitude) {
      boundslatlng = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
        northeast: LatLng(originLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      boundslatlng =
          LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
    }
//camera update on boundslatlng
    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(boundslatlng, 65));
//FOR origin  maker on map
    Marker originMarker = Marker(
      markerId: MarkerId("originID"),
      infoWindow:
          InfoWindow(title: originPosition.locationName, snippet: "Origin"),
      position: originLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    //FOR destination  maker on map
    Marker destinationMarker = Marker(
      markerId: MarkerId("destinationID"),
      infoWindow: InfoWindow(
          title: destinationPosition.locationName, snippet: "Destination"),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    //set the makers
    setState(() {
      markersSet.add(originMarker);
      markersSet.add(destinationMarker);
    });

    //add circles for origin
    Circle originCircle = Circle(
      circleId: CircleId("originID"),
      fillColor: Colors.blue,
      radius: 12,
      strokeColor: Colors.white,
      center: originLatLng,
    );

    //add circles for destination
    Circle destinationCircle = Circle(
      circleId: CircleId("destinationID"),
      fillColor: Colors.red,
      radius: 12,
      strokeColor: Colors.white,
      center: destinationLatLng,
    );
    setState(() {
      circlesSet.add(originCircle);
      circlesSet.add(destinationCircle);
    });
  }

//   getAddressFromLatLng() async {
//     try {
//       GeoData data = await Geocoder2.getDataFromCoordinates(
//           latitude: pickLocation!.latitude,
//           longitude: pickLocation!.longitude,
//           googleMapApiKey: mapkey);

//       setState(() {
//         Directions userPickUpAddress = Directions();
//         userPickUpAddress.locationLatitude = pickLocation!.latitude;
//         userPickUpAddress.locationLongitude = pickLocation!.longitude;
//         userPickUpAddress.locationName = data.address;
//         // _address = data.address;

// //provider code
//         Provider.of<AppInfo>(context, listen: false)
//             .updatePickUpLocationAddress(userPickUpAddress);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    //if denied
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  //user has permission to allow location

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    bool darktheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    createActiveNearByDriverIconMarker();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldState,
        //drawer
        drawer: DrawerScreen(),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(top: 40, bottom: bottomPaddingofMap),
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: _kGooglePlex,
              polylines: polylineSet,
              markers: markersSet,
              circles: circlesSet,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                setState(() {
                  bottomPaddingofMap = 200;
                });
                //function locate user position
                locateUserPosition();
              },
              //   //pick location using camera
              //   onCameraMove: (CameraPosition? position) {
              //     if (pickLocation != position!.target) {
              //       setState(() {
              //         pickLocation = position.target;
              //       });
              //     }
              //   },
              //   //get address
              //   onCameraIdle: () {
              //     getAddressFromLatLng();
              //   },
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 35.0),
            //     child: Image.asset(
            //       'assets/images/pickicon.png',
            //       height: 45,
            //       width: 45,
            //     ),
            //   ),
            // ),

            //drawer customized button
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    _scaffoldState.currentState!.openDrawer();
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        darktheme ? Colors.amber.shade400 : Colors.white,
                    child: Icon(
                      Icons.menu,
                      color: darktheme ? Colors.black : Colors.green,
                    ),
                  ),
                ),
              ),
            ),

            //userinterface for searching
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: darktheme ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: darktheme
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          color: darktheme
                                              ? Colors.amber.shade400
                                              : Colors.blue),

                                      //sized box
                                      SizedBox(
                                        width: 12,
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "From",
                                            style: TextStyle(
                                              color: darktheme
                                                  ? Colors.amber.shade400
                                                  : Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            Provider.of<AppInfo>(context)
                                                        .userPickUpLocation !=
                                                    null
                                                ? (Provider.of<AppInfo>(context)
                                                            .userPickUpLocation!
                                                            .locationName!)
                                                        .substring(0, 24) +
                                                    "..."
                                                : "Not getting Address",
                                            // Provider.of<AppInfo>(context)
                                            //             .userPickUpLocation !=
                                            //         null
                                            //     ? Provider.of<AppInfo>(context)
                                            //         .userPickUpLocation!
                                            //         .locationName!
                                            //     : "Not getting Address",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                //sized box
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: darktheme
                                      ? Colors.amber.shade400
                                      : Colors.blue,
                                ),
                                //sized box
                                SizedBox(
                                  height: 20,
                                ),

                                //padding
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: GestureDetector(
                                    onTap: () async {
                                      ///////////////////////////////
                                      ///Go to search place screen
                                      var responseFromSearchScreen =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      SearchPlacesScreen()));
                                      ////////////////////////
                                      if (responseFromSearchScreen ==
                                          "obtainedDropoff") {
                                        setState(() {
                                          openNavigationDrawer = false;
                                        });
                                      }

                                      //polyline drawing
                                      await drwaPolylineFromOriginToDestination(
                                          darktheme);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: darktheme
                                              ? Colors.amber.shade400
                                              : Colors.green,
                                        ),

                                        //sized box
                                        SizedBox(
                                          width: 12,
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Towing vehicle to",
                                              style: TextStyle(
                                                color: darktheme
                                                    ? Colors.amber.shade400
                                                    : Colors.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              /////////////
                                              Provider.of<AppInfo>(context)
                                                          .userDropOffLocation !=
                                                      null
                                                  ? (Provider.of<AppInfo>(
                                                          context)
                                                      .userDropOffLocation!
                                                      .locationName!)
                                                  : "Towing it to",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //sized box
                          SizedBox(
                            height: 5,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) =>
                                              PrecisePickupScreen()));
                                },
                                child: Text(
                                  "Change Pickup",
                                  style: TextStyle(
                                    color:
                                        darktheme ? Colors.black : Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: darktheme
                                      ? Colors.amber.shade400
                                      : Colors.greenAccent,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              //sized box
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Order Service",
                                  style: TextStyle(
                                    color:
                                        darktheme ? Colors.black : Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: darktheme
                                      ? Colors.amber.shade400
                                      : Colors.orangeAccent,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )

            //see whether position changes
            //testing
            // Positioned(
            //   top: 40,
            //   right: 20,
            //   left: 20,
            //   child: Container(
            //     decoration: BoxDecoration(
            //         border: Border.all(
            //           color: Colors.black,
            //         ),
            //         color: Colors.white),
            //     padding: EdgeInsets.all(20),
            //     child: Text(
            //       Provider.of<AppInfo>(context).userPickUpLocation != null
            //           ? (Provider.of<AppInfo>(context)
            //                       .userPickUpLocation!
            //                       .locationName!)
            //                   .substring(0, 24) +
            //               "..."
            //           : "Not getting Address",
            //       overflow: TextOverflow.visible,
            //       softWrap: true,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
