import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  final double accountBalance;

  // Provide a default value (0.0) for the accountBalance parameter
  UserAccount({this.accountBalance = 0.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add functionality here to handle the tap event
        print('User account tapped');
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'natukundaphionah@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Account',
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 10),
            Text(
              'Balance: \$${accountBalance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality here to handle the button press
                print('Edit Profile button pressed');
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Account Widget'),
        ),
        body: UserAccount(),
      ),
    );
  }
}
