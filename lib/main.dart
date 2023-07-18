import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('My Mechanic App'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: const Center(
        child: Text('This is my mechanic App',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey,
              fontFamily: 'IndieFlower',
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Button Clicked');
        },
        backgroundColor: Colors.red[600],
        child: const Text(
          'Click',
          style: TextStyle(
            fontFamily: 'IndieFlower',
          ),
        ),
      ),
    ),
  ));
}
