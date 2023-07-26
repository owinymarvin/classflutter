import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.list),
              iconSize: 50,
              color: Colors.white,
              enableFeedback: true,
              elevation: 10,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              // position:,
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("My Account"),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Settings"),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("Logout"),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  print("My account menu is selected.");
                } else if (value == 1) {
                  print("Settings menu is selected.");
                } else if (value == 2) {
                  print("Logout menu is selected.");
                }
              },
            ),
          ],
          title: Text('Car Towing Service'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          scrolledUnderElevation: 10.0,
        ),
        body: Container(
          color: Colors.grey[400],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.red,
          height: 80,
          // padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.report),
                    color: Colors.white,
                  ),
                  const Text(
                    'Report',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.home_filled),
                    color: Colors.white,
                  ),
                  const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.supervisor_account_sharp),
                    color: Colors.white,
                  ),
                  const Text(
                    'Account',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
