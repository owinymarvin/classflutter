import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:towdrivers/Assistant/assistant_methods.dart';
import 'package:towdrivers/global/global.dart';
import 'package:towdrivers/model/user_ride_request_information.dart';

import '../All_screens/new_trip_screen.dart';

class NotificationDialogueBox extends StatefulWidget {
  UserRideRequestInformation? userRideRequestDetails;
  NotificationDialogueBox({this.userRideRequestDetails});
  @override
  State<NotificationDialogueBox> createState() =>
      _NotificationDialogueBoxState();
}

class _NotificationDialogueBoxState extends State<NotificationDialogueBox> {
  @override
  Widget build(BuildContext context) {
    bool darkthem =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        margin: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: darkthem ? Colors.black : Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              onlineDriverData.car_type == "Flatbed"
                  ? "assets/images/redmarker.png"
                  : onlineDriverData.car_type == "Hook&Chain"
                      ? "assets/images/redmarker.png"
                      : "assets/images/redmarker.png",
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              "New Ride Request",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: darkthem ? Colors.amber.shade400 : Colors.greenAccent,
              ),
            ),

            SizedBox(
              height: 14,
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: darkthem ? Colors.amber.shade400 : Colors.greenAccent,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/tow2.png",
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.userRideRequestDetails!.originAddress!,
                            style: TextStyle(
                              fontSize: 16,
                              color: darkthem
                                  ? Colors.amber.shade400
                                  : Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/desticon1.png",
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.userRideRequestDetails!.destinationAddress!,
                            style: TextStyle(
                              fontSize: 16,
                              color: darkthem
                                  ? Colors.amber.shade400
                                  : Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            Divider(
              height: 2,
              thickness: 2,
              color: darkthem ? Colors.amber.shade400 : Colors.greenAccent,
            ),

            //buttons for acceptin and canceling

            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      audioPlayer.pause();
                      audioPlayer.stop();
                      audioPlayer = AssetsAudioPlayer();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      audioPlayer.pause();
                      audioPlayer.stop();
                      audioPlayer = AssetsAudioPlayer();

                      acceptRideRequest(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text(
                      "Accept".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  acceptRideRequest(BuildContext context) {
    FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(firebaseAuth.currentUser!.uid)
        .child("newRideStatus")
        .once()
        .then((snap) {
      if (snap.snapshot.value == "idle") {
        FirebaseDatabase.instance
            .ref()
            .child("drivers")
            .child(firebaseAuth.currentUser!.uid)
            .child("newRideStatus")
            .set("accepted");

        AssistantMethods.pauseLiveLoctionUpdates();
        //trip started now send driver to new trip screen
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => NewTripScreen()));
      } else {
        Fluttertoast.showToast(msg: "This Ride Request dose not exist.");
      }
    });
  }
}
