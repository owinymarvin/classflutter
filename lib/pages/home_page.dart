// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstpro/home_contents/account.dart';
import 'package:firstpro/home_contents/home.dart';
import 'package:firstpro/home_contents/profile_page.dart';
import 'package:firstpro/home_contents/settings.dart';
import 'package:firstpro/home_contents/tow_service.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/features/my_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

// navigate to profile page
  void goToProfilePage() {
//pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  //to be able to change selected index(Page)
  int selectedIndex = 0;

  //create a navigation function
  void navigateBottomBar(int index) {
    //in order to navigate we need to know the index the user is tapping
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    UserHome(),
    UserAccount(),
    UserSettings(),
    UserTowServices(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar designs
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        title: Text('Tow Services'),
        actions: [
          //do something
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      //scaffold background color
      backgroundColor: Colors.grey[300],
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onsignOut: signOut,
      ),

      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
          child: GNav(
            // currentIndex: selectedIndex,
            onTabChange: navigateBottomBar,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            tabs: [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.car_repair_sharp, text: 'tow'),
              GButton(icon: Icons.settings, text: 'settings'),
              GButton(icon: Icons.person, text: 'Account'),
            ],
          ),
        ),
      ),
    );
  }
}
