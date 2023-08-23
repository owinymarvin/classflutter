import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:towdrivers/Assistant/assistant_methods.dart';
import 'package:towdrivers/global/global.dart';
import 'package:towdrivers/model/user_ride_request_information.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../All_screens/new_trip_screen.dart';
import 'package:towdrivers/tabPages/home_tab.dart';

class NotificationDialogueBox extends StatefulWidget {
  NotificationDialogueBox({super.key, this.userRideRequestDetails});
  UserRideRequestInformation? userRideRequestDetails;

  @override
  State<NotificationDialogueBox> createState() =>
      _NotificationDialogueBoxState();
}

class _NotificationDialogueBoxState extends State<NotificationDialogueBox> {
  acceptRideRequest(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => NewTripScreen()));
  }

  Query dbref = FirebaseDatabase.instance
      .ref()
      .child('All Tow ride request')
      .orderByChild('time')
      .limitToLast(1);

  Widget listItem({required Map AllTowRequests}) {
    bool darkthem =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (DateTime.parse(AllTowRequests['time'])
        .isAfter(DateTime.now().subtract(Duration(minutes: 2)))) {
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
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(
              "assets/images/tow2.png",
              height: 200,
            ),
            SizedBox(height: 2),
            Text(
              "New Ride Request",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: darkthem ? Colors.amber.shade400 : Colors.greenAccent,
              ),
            ),
            SizedBox(height: 2),
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
                            'originAddress: ' + AllTowRequests['originAddress'],
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
                  SizedBox(height: 20),
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
                            'destinationAddress: ' +
                                AllTowRequests['destinationAddress'],
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
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'userName: ' + AllTowRequests["userName"],
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
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'userPhone: ' + AllTowRequests['userPhone'],
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
                  SizedBox(width: 20),
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
          ]),
        ),
      );
    } else {
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
                "assets/images/tow2.png",
                height: 200,
              ),
              SizedBox(height: 2),
              Text(
                "Searching for requests",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: darkthem ? Colors.amber.shade400 : Colors.greenAccent,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    // Container(
    //   margin: EdgeInsets.all(10),
    //   padding: EdgeInsets.all(10),
    //   height: 220,
    //   color: Colors.amber,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('origin Lat: ' + AllTowRequests['origin']['latitude']),
    //       Text('origin long: ' + AllTowRequests['origin']['longitude']),
    //       Text('destn lat: ' + AllTowRequests['destination']['latitude']),
    //       Text('destn long: ' + AllTowRequests['destination']['longitude']),
    //       Text('time: ' + AllTowRequests['time']),
    //       Text('userName: ' + AllTowRequests["userName"]),
    //       Text('userPhone: ' + AllTowRequests['userPhone']),
    //       Text('originAddress: ' + AllTowRequests['originAddress']),
    //       Text('destinationAddress: ' + AllTowRequests['destinationAddress']),
    //       Text('driverId: ' + AllTowRequests['driverId']),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map AllTowRequestsMap = snapshot.value as Map;
            AllTowRequestsMap['key'] = snapshot.key;
            return listItem(AllTowRequests: AllTowRequestsMap);
          },
        ),
      ),
    );
  }
}
