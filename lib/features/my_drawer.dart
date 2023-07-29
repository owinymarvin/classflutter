import 'package:firstpro/features/drawer_items.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  //function to go to user profile
  final void Function()? onProfileTap;
  //function to logout user
  final void Function()? onsignOut;
  const MyDrawer({
    super.key,
    required this.onsignOut,
    required this.onProfileTap,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      //place all the items in a column and later the...
      child: Column(
        //main axis to place space between the drawer items
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //header
              DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),

              //home
              DrawerItems(
                icon: Icons.home,
                text: 'H o m e',
                onTap: () => Navigator.pop(context),
              ),

              //profile
              DrawerItems(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: onProfileTap,
              ),
            ],
          ),

          //logout
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: DrawerItems(
              icon: Icons.logout,
              text: 'L O G O U T',
              onTap: onsignOut,
            ),
          ),
        ],
      ),
    );
  }
}
