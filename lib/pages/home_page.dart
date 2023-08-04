import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstpro/home_contents/account.dart';
import 'package:firstpro/home_contents/profile_page.dart';
import 'package:firstpro/home_contents/settings.dart';
import 'package:firstpro/home_contents/user_tow_services.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/features/my_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToProfilePage() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  int _selectedIndex = 0;
  var navBarColor = const Color.fromARGB(188, 76, 175, 79);

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        navBarColor = const Color.fromARGB(188, 76, 175, 79);
      } else if (index == 1) {
        navBarColor = const Color.fromARGB(188, 244, 67, 54);
      } else {
        navBarColor = const Color.fromARGB(188, 155, 39, 176);
      }

      _selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const UserTowServices(),
    UserAccount(),
    UserSettings(),
  ];

  // void main() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar designs
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: navBarColor,
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

      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? SvgPicture.asset(
                    'lib/images/tow1.svg',
                    semanticsLabel: 'Car towing image',
                    width: 30,
                    color: Colors.white,
                  )
                : SvgPicture.asset(
                    'lib/images/tow1.svg',
                    semanticsLabel: 'Car towing image',
                    width: 30,
                    // color: Colors.white,
                  ),
            label: 'Tow',
            backgroundColor: const Color.fromARGB(188, 76, 175, 79),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.eighteen_up_rating),
            label: 'Rating',
            backgroundColor: Color.fromARGB(188, 244, 67, 54),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color.fromARGB(188, 155, 39, 176),
          )
        ],
        //
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: navBarColor,
      ),
    );
  }
}
