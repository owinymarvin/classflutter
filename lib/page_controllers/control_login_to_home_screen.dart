import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cartowingservice/page_controllers/control_toggle_login_&_singup_screens.dart';
import 'package:cartowingservice/pages/home_screen.dart';

class MainAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();

            //user not logged in
          } else {
            return LoginRegisterScreen();
          }
        },
      ),
    );
  }
}
