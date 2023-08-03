import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstpro/home_contents/account.dart';
import 'package:firstpro/home_contents/home.dart';
import 'package:firstpro/home_contents/profile_page.dart';
import 'package:firstpro/home_contents/settings.dart';
import 'package:firstpro/home_contents/tow_service.dart';
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
  //
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
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var navBarColor = const Color.fromARGB(188, 244, 67, 54);

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        navBarColor = const Color.fromARGB(188, 244, 67, 54);
      } else if (index == 1) {
        navBarColor = const Color.fromARGB(188, 76, 175, 79);
      } else if (index == 2) {
        navBarColor = const Color.fromARGB(188, 155, 39, 176);
      } else if (index == 3) {
        navBarColor = const Color.fromARGB(188, 233, 30, 98);
      }
      _selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    UserHome(),
    const UserTowServices(),
    UserAccount(),
    UserSettings(),
  ];

  void main() async {
    final headers = {
      // Request headers
      'Authorization': '',
      'X-Target-Environment': '',
      'X-Callback-Url': '',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Ocp-Apim-Subscription-Key': '{subscription key}',
    };

    // ignore: unused_local_variable
    final params = Uri(queryParameters: {}).query;

    final url = Uri.https(
        'sandbox.momodeveloper.mtn.com', '/collection/v1_0/bc-authorize', {});

    try {
      final response = await http.post(url, headers: headers, body: {});
      print(response.body);
    } catch (e) {
      print('Error: $e');
    }
  }

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
          const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(188, 244, 67, 54)),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/images/tow1.svg',
              semanticsLabel: 'Car towing image',
              width: 30,
              color: Colors.white,
            ),
            label: 'Tow',
            backgroundColor: const Color.fromARGB(188, 76, 175, 79),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
            backgroundColor: Color.fromARGB(188, 155, 39, 176),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color.fromARGB(188, 233, 30, 98),
          ),
        ],
        //
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
    // bottomNavigationBar: Container(
    //   color: Colors.black,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
    //     child: GNav(
    //       // currentIndex: selectedIndex,
    //       onTabChange: navigateBottomBar,
    //       backgroundColor: Colors.black,
    //       color: Colors.white,
    //       activeColor: Colors.white,
    //       tabBackgroundColor: Colors.grey.shade800,
    //       gap: 8,
    //       tabs: [
    //         GButton(icon: Icons.home, text: 'Home'),
    //         GButton(icon: Icons.car_repair_sharp, text: 'tow'),
    //         GButton(icon: Icons.settings, text: 'settings'),
    //         GButton(icon: Icons.person, text: 'Account'),
    //       ],
    //     ),
  }
}
