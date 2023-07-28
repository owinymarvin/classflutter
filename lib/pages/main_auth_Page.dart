import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'home_page.dart';
import 'login_or_register_page.dart';
import 'package:firstpro/pages/user_interface_after_login.dart';


class MainAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyApp();

            //user not logged in
          } else {
            return loginOrRegisterPage();
          }
        },
      ),
    );
  }
}
