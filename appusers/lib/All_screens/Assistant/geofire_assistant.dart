import 'package:appusers/model/active_nearby_available_drivers.dart';

class GeoFireAssistant {
  static List<ActiveNearByAvailableDrivers> ActiveNearByAvailableDriversList =
      [];
  static void deleteOfflineDriverFromList(String driverId) {
    int indexNumber = ActiveNearByAvailableDriversList.indexWhere(
        (element) => element.driverId == driverId);

    ActiveNearByAvailableDriversList.removeAt(indexNumber);
  }

  static void updateActiveNearByAvailableDriverLocation(
      ActiveNearByAvailableDrivers driverWhoMove) {
    int indexNumber = ActiveNearByAvailableDriversList.indexWhere(
        (element) => element.driverId == driverWhoMove.driverId);
    ///////
    ActiveNearByAvailableDriversList[indexNumber].locationLatitude =
        driverWhoMove.locationLatitude;
//////////
    ActiveNearByAvailableDriversList[indexNumber].locationLongitude =
        driverWhoMove.locationLongitude;
  }
}
