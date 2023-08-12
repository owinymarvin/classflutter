import 'dart:async';
import 'package:appusers/All_screens/Search_Places.dart';
import 'package:appusers/Assistant/assistant_methods.dart';
import 'package:appusers/global/global.dart';
import 'package:appusers/global/map_key.dart';
import 'package:appusers/info_handler/app_info.dart';
import 'package:appusers/widgets/progressdialog.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../model/directions.dart';

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

    // intializeGeoFireListener();
    // AssistantMethods.readTripkeysForOnlineUser(context);
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
        originPosition!.locationLatitude!, originPosition!.locationLongitude!);

    var destinationLatLng = LatLng(destinationPosition!.locationLatitude!,
        destinationPosition!.locationLongitude!);

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

  getAddressFromLatLng() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: pickLocation!.latitude,
          longitude: pickLocation!.longitude,
          googleMapApiKey: mapkey);

      setState(() {
        Directions userPickUpAddress = Directions();
        userPickUpAddress.locationLatitude = pickLocation!.latitude;
        userPickUpAddress.locationLongitude = pickLocation!.longitude;
        userPickUpAddress.locationName = data.address;
        // _address = data.address;

//provider code
        Provider.of<AppInfo>(context, listen: false)
            .updatePickUpLocationAddress(userPickUpAddress);
      });
    } catch (e) {
      print(e);
    }
  }

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
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

                setState(() {});
                //function locate user position
                locateUserPosition();
              },
              //pick location using camera
              onCameraMove: (CameraPosition? position) {
                if (pickLocation != position!.target) {
                  setState(() {
                    pickLocation = position.target;
                  });
                }
              },
              //get address
              onCameraIdle: () {
                getAddressFromLatLng();
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Image.asset(
                  'assets/images/pickicon.png',
                  height: 45,
                  width: 45,
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
                                        width: 10,
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
                                          width: 10,
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
