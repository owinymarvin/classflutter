import 'package:cartowingservice/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckUserAuth {
  static checkLoginStatus(BuildContext context) async {
    // Check the current user's authentication status
    User? user = FirebaseAuth.instance.currentUser;

    // If the user is already logged in, navigate to the home page
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }
}
