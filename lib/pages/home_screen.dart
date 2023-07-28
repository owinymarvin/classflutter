import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(30, 30, 20, 0),
                ),
                child: Text('MORE OPTIONS'),
              ),
              ListTile(
                title: Text('HOME'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: Text('ROAD SIGNS'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    // Navigate to the Road Signs screen
                    context,
                    MaterialPageRoute(builder: (context) => RoadSignsScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('DRIVING TIPS'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    // Navigate to the Driving Tips screen
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrivingTipsScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('TOWING SERVICES'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    // Navigate to the Towing Services screen
                    context,
                    MaterialPageRoute(
                        builder: (context) => TowingServicesPage()),
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("*****WELCOME USER TO CAR TOWING SERVICE ****"),
          backgroundColor: Color.fromARGB(255, 5, 142, 211),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 30, 40, 50),
                Color.fromARGB(255, 43, 43, 54),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Center(
            child: Text(
              'Towing cars',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 20,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 90,
          color: Colors.amberAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.report,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        // Add functionality for onPressed if needed
                      },
                    ),
                    Text('REPORT'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.supervisor_account_sharp,
                        color: Color.fromARGB(255, 96, 139, 106),
                      ),
                      onPressed: () {
                        // Add functionality for onPressed if needed
                      },
                    ),
                    Text('ACCOUNT'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home_filled,
                        color: Colors.blueGrey,
                      ),
                      onPressed: () {
                        // Add functionality for onPressed if needed
                      },
                    ),
                    Text('HOME'),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add functionality for FloatingActionButton onPressed
          },
          child: Text('+'),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}

class RoadSignsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Road Signs'),
      ),
      body: Center(
        child: Text('Road Signs Screen'),
      ),
    );
  }
}

class DrivingTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driving Tips'),
      ),
      body: Center(
        child: Text('Driving Tips Screen'),
      ),
    );
  }
}

class TowingServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Towing Services'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Towing Service 1'),
            subtitle: Text('Description of Towing Service 1'),
            onTap: () {
              // Add functionality to perform actions when this service is selected
            },
          ),
          ListTile(
            title: Text('Towing Service 2'),
            subtitle: Text('Description of Towing Service 2'),
            onTap: () {
              // Add functionality to perform actions when this service is selected
            },
          ),
          // Add more ListTile widgets for other towing services
        ],
      ),
    );
  }
}
