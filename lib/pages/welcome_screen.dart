import 'package:firstpro/pages/main_auth_Page.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  final Function()? ontap;
  const WelcomeScreen({super.key, required this.ontap});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Set the screen background color to grey[300]
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace the Icon widget with an Image widget
            Image.asset(
              'lib/images/tow2.png', // Replace 'build_icon.png' with the actual image path in your assets folder
              width: 120,
              height: 120,

              // color:
              //     Colors.grey[200], // You can add color to the image if needed
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Tow Services!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900], // Set text color to white
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainAuthPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors
                    .deepPurple, // Set button background color to grey[900]
                onPrimary: Colors.white, // Set button text color to white
              ),
              child: Text(
                'Get started',
                textScaleFactor: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
