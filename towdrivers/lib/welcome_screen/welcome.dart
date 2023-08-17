import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../All_screens/homepage.dart';
import '../All_screens/login.dart';
import '../Assistant/assistant_methods.dart';
import '../global/global.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  startTimer() {
    Timer(Duration(seconds: 5), () async {
      if (await firebaseAuth.currentUser != null) {
        firebaseAuth.currentUser != null
            ? AssistantMethods.readCurrentOnlineUserInfo()
            : null;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MyHomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

//calling the timer in an initstate
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/tow1.svg',
              semanticsLabel: 'Car towing image',
              width: 280,
              color: Colors.greenAccent,
            ),
            Text(
              "TOW DRIVERS",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Signatra',
                  color: Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}
