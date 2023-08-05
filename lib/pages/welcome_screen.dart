import 'package:firstpro/pages/main_auth_Page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  final Function()? ontap;

  const WelcomeScreen({Key? key, required this.ontap}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "lib/images/truck1.jpeg",
              width: 300, // Set the width of the image
              height: 300, // Set the height of the image
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to Tow Services!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900], // Set text color to white
              ),
            ),
            const SizedBox(height: 60),
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
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text(
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
