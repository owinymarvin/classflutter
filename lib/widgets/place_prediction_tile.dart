import 'package:appusers/Assistant/request_Assistant.dart';
import 'package:appusers/info_handler/app_info.dart';
import 'package:appusers/model/directions.dart';
// import 'package:appusers/widget/progressdialog.dart';
import 'package:appusers/widgets/progressdialog.dart';
// import 'package:appusers/widgets/progress_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';
import '../global/map_key.dart';
import '../model/prediction_places.dart';

class PlacePredictionDesign extends StatefulWidget {
  final PredictedPlaces? predictedPlaces;
  PlacePredictionDesign({this.predictedPlaces});

  @override
  State<PlacePredictionDesign> createState() => _PlacePredictionDesignState();
}

class _PlacePredictionDesignState extends State<PlacePredictionDesign> {
  //directions of places
  getPlaceDirectionDetails(String? placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "setting up dropoff. please wait...",
            ));

    String placeDirectionDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapkey";
    var responseApi =
        await RequestAssitant.receiveRequest(placeDirectionDetailsUrl);
    Navigator.pop(context);

    if (responseApi == "Error ocurred. Failed. No Response.") {
      return;
    }

    if (responseApi["status"] == "OK") {
      Directions directions = Directions();
      directions.locationName = responseApi["result"]["name"];
      directions.locationId = placeId;
      directions.locationLatitude =
          responseApi["result"]["geometry"]["location"]["lat"];
      directions.locationLongitude =
          responseApi["result"]["geometry"]["location"]["lng"];

      Provider.of<AppInfo>(context, listen: false)
          .updateDropOffLocationAddress(directions);

      setState(() {
        userDropOffAddress = directions.locationName!;
      });

      Navigator.pop(context, "obtainedDropoff");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darktheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ElevatedButton(
      onPressed: () {
        getPlaceDirectionDetails(widget.predictedPlaces!.place_id, context);
      },
      style: ElevatedButton.styleFrom(
        primary: darktheme ? Colors.black : Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.add_location,
                color: darktheme ? Colors.amber.shade400 : Colors.blue),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.predictedPlaces!.main_text!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: darktheme ? Colors.amber.shade400 : Colors.blue,
                  ),
                ),

                //secondary text
                Text(
                  widget.predictedPlaces!.secondary_text!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: darktheme ? Colors.amber.shade400 : Colors.blue,
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
