import 'dart:async';

import 'package:appusers/All_screens/homepage.dart';
import 'package:appusers/All_screens/login.dart';
import 'package:appusers/Assistant/assistant_methods.dart';
import 'package:appusers/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Empowering Your Journeys",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
            Text(
              "with Reliable Towing Solutions",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 20),
            SvgPicture.asset(
              'assets/images/tow1.svg',
              semanticsLabel: 'Car towing image',
              color: Colors.greenAccent,
              width: 280,
            ),
            SizedBox(height: 20),
            Text(
              "Quick Assistance",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Get help fast! Our app connects you with reliable towing professionals in minutes.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
