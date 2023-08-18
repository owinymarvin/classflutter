import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towdrivers/Assistant/request_Assistant.dart';

import '../global/global.dart';
import '../global/map_key.dart';
import '../info_handler/app_info.dart';
import '../model/direction_details_info.dart';
import '../model/directions.dart';
import '../model/user_model.dart';

class AssistantMethods {
  static void readCurrentOnlineUserInfo() async {
    currentUser = firebaseAuth.currentUser;

    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users').child(currentUser!.uid);

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentinfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<String> searchAddressForGeographicCoordinates(
      Position position, context) async {
    String apiurl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";
    String humanReadableAddress = "";

    var requestResponse = await RequestAssitant.receiveRequest(apiurl);

    if (requestResponse != "Error ocurred, Failed, No Response") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }

    return humanReadableAddress;
  }

//method
  static Future<DirectionDetailsInfo>
      obtainOriginToDestinationDirectionsDetails(
          LatLng originPosition, LatLng destinationPosition) async {
    String urlOriginToDestinationDirectionDetails =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapkey";

    var responseDirectionApi = await RequestAssitant.receiveRequest(
        urlOriginToDestinationDirectionDetails);
    // if (responseDirectionApi == "Error ocurred. Failed. No Response.") {
    //   return null;
    // }
    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points =
        responseDirectionApi["routes"][0]["overview_polyline"]["points"];
    directionDetailsInfo.distance_text =
        responseDirectionApi["routes"][0]["legs"][0]["distance"]["text"];

    directionDetailsInfo.distance_Value =
        responseDirectionApi["routes"][0]["legs"][0]["distance"]["value"];

    directionDetailsInfo.duration_text =
        responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];
    directionDetailsInfo.duration_value =
        responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];
    //return
    return directionDetailsInfo;
  }

  static pauseLiveLoctionUpdates() {
    streamSubscriptionPosition!.pause();
    Geofire.removeLocation(firebaseAuth.currentUser!.uid);
  }
}
