import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:towdrivers/model/driver_data.dart';

// import '../model/direction_details_info.dart';
import '../model/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;
StreamSubscription<Position>? streamSubscriptionPosition;
StreamSubscription<Position>? streamSubscriptionDriverLivePosition;
UserModel? userModelCurrentinfo;
Position? driverCurrentPosition;
DriverData onlineDriverData = DriverData();
String? driverVehicleType = "";
