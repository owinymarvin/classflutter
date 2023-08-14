// import 'package:appusers/global/global.dart';
import 'package:appusers/All_screens/profile_screen.dart';
import 'package:appusers/global/global.dart';
import 'package:appusers/welcome_screen/welcome.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.all(35),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    userModelCurrentinfo!.name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  //SIZED BOX
                  SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => ProfileScreen()));
                    },
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.greenAccent),
                    ),
                  ),

                  //sized box
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Your Orders",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  //sized box
                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  //sized box
                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  //sized box
                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Help",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  //sized box
                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Free tow service offers",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  //sized box
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),

              //gesture detector
              GestureDetector(
                onTap: () {
                  firebaseAuth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => WelcomeScreen()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: "Bold-Regular",
                    color: Colors.orangeAccent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
