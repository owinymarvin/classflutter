import 'package:flutter/material.dart';
// import 'package:towdrivers/global/global.dart';
// import 'package:towdrivers/welcome_screen/welcome.dart';

import '../tabPages/home_Tab.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //variables
  TabController? tabController;
  int selectedIndex = 0;

  //items clicked
  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  //int state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // for theme  colors
    bool darktheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeTabPage(),
          // EarningsTabPage(),
          // RatingsTabPage(),
          // ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: "Earnings"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Ratings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
        unselectedItemColor: darktheme ? Colors.black54 : Colors.white54,
        selectedItemColor: darktheme ? Colors.black : Colors.white,
        backgroundColor: darktheme ? Colors.amber.shade400 : Colors.greenAccent,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
