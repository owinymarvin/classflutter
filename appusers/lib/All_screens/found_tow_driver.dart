import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:appusers/All_screens/homepage.dart';

class FoundTowDriver extends StatefulWidget {
  FoundTowDriver({super.key});

  @override
  State<FoundTowDriver> createState() => _FoundTowDriverState();
}

class _FoundTowDriverState extends State<FoundTowDriver> {
  acceptRideRequest(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => MyHomePage()));
  }

  Query dbref = FirebaseDatabase.instance
      .ref()
      .child('drivers')
      .orderByChild('newTowStatus')
      .limitToLast(1);

  Widget listItem({required Map FoundTowDriver}) {
    bool darkthem =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (FoundTowDriver['newTowStatus'] == 'idle') {
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
              "Found Tow Truck",
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
                      Icon(Icons.person),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'Name: ' + FoundTowDriver['name'],
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
                      Icon(Icons.phone_android),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'Phone: ' + FoundTowDriver['phone'],
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
                      Icon(Icons.email),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'email: ' + FoundTowDriver["email"],
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
                            'Address: ' + FoundTowDriver["address"],
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
                            'car_details: ' +
                                FoundTowDriver["car_details"]['car_number'],
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
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => MyHomePage()));
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
                "Searching for Tow Truck",
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
            Map FoundTowDriverMap = snapshot.value as Map;
            FoundTowDriverMap['key'] = snapshot.key;
            return listItem(FoundTowDriver: FoundTowDriverMap);
          },
        ),
      ),
    );
  }
}
