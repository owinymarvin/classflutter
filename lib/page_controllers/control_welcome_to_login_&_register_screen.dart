import 'package:cartowingservice/page_controllers/control_toggle_login_&_singup_screens.dart';
import 'package:cartowingservice/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

class WelcomeStartScreen extends StatefulWidget {
  const WelcomeStartScreen({super.key});

  @override
  State<WelcomeStartScreen> createState() => _WelcomeStartScreenState();
}

class _WelcomeStartScreenState extends State<WelcomeStartScreen> {
  Widget? currentAppScreen;

  @override
  void initState() {
    currentAppScreen = WelcomeScreen(screenSwitcher);
    super.initState();
  }

  void screenSwitcher() {
    setState(() {
      currentAppScreen = LoginRegisterScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 117, 5, 145),
                Color.fromARGB(155, 117, 5, 145),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: currentAppScreen,
        ),
      ),
    );
  }
}
