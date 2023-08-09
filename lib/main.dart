// import 'package:firebase_auth/firebase_auth.dart';

import 'package:appusers/All_screens/homepage.dart';
import 'package:appusers/All_screens/login.dart';
import 'package:appusers/All_screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'DataHandler/appData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("Users");
DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tow service app',
      theme: ThemeData( 
        fontFamily: "Brand-Regular",
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MyHomePage.idScreen,
      routes: {
        RegisterPage.idScreen: (context) => RegisterPage(),
        LoginPage.idScreen: (context) => LoginPage(),
        MyHomePage.idScreen: (context) => MyHomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
