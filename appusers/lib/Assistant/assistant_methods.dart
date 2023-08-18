import 'dart:convert';

import 'package:appusers/Assistant/request_Assistant.dart';
import 'package:appusers/global/global.dart';
import 'package:appusers/model/directions.dart';
import 'package:appusers/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../global/map_key.dart';
import '../info_handler/app_info.dart';
import '../model/direction_details_info.dart';
import 'package:http/http.dart' as http;

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

  static double calculateFareAmountFromOriginToDestination(
      DirectionDetailsInfo directionDetailsInfo) {
    double timeTravelledFareAmountPerMinute =
        (directionDetailsInfo.duration_value! / 60) * 0.1;
    /////////
    double distanceTravelledFareAmountPerKilometer =
        (directionDetailsInfo.duration_value! / 1000) * 0.1;

    //
    double totalFareAmount = timeTravelledFareAmountPerMinute +
        distanceTravelledFareAmountPerKilometer;
    return double.parse(totalFareAmount.toStringAsFixed(1));
  }

  static sendNotificationToDriverNow(
      String deviceRegistrationToken, String userRideRequestId, context) async {
    String destinationAddress = userDropOffAddress;

    Map<String, String> headerNotification = {
      'Content-Type': 'application/json',
      'Authorization': cloudMessagingServerToken,
    };
    Map bodyNotification = {
      "body": "Destination Address:\n$destinationAddress.",
      "title": "New Trip Request"
    };

    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "rideRequestId": userRideRequestId
    };

    Map officialNotificationFormat = {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": deviceRegistrationToken,
    };

    var responseNotification = http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );
  }
}
