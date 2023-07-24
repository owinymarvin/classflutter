import 'package:flutter/material.dart';
import 'package:firstpro/pages/login_screen.dart';

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
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.build,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Vehicle Tow App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      onTap: () {},
                    ),
                  ),
                );
              },
              child: Text('Get started'),
            ),
          ],
        ),
      ),
    );
  }
}
