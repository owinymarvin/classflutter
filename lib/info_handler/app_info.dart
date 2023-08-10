import 'package:appusers/model/directions.dart';
import 'package:flutter/material.dart';

class AppInfo extends ChangeNotifier {
  Directions? userPickUpLocation, userDropOffLocation;
  int coutTotalTrips = 0;
  // List<String> historyTripsKey = [];
  // List<TripsHistoryModel> allTripsHistoryInformationList = [];

  void UpdatePickUpLocationAddress(Directions userPickUpAddress) {
    userPickUpLocation = userPickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Directions dropOffAddress) {
    userDropOffLocation = dropOffAddress;
    notifyListeners();
  }
}
