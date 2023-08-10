import 'dart:async';

import 'package:appusers/All_screens/homepage.dart';
import 'package:appusers/All_screens/login.dart';
import 'package:appusers/Assistant/assistant_methods.dart';
import 'package:appusers/global/global.dart';
import 'package:flutter/material.dart';

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
        child: Text(
          "TOW SERVICES",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            fontFamily: 'Signatra',
          ),
        ),
      ),
    );
  }
}
