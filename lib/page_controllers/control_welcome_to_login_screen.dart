import 'package:cartowingservice/main.dart';
import 'package:cartowingservice/page_controllers/control_toggle_login_and_singup_screens.dart';
import 'package:cartowingservice/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreenController extends StatefulWidget {
  const WelcomeScreenController({super.key});

  @override
  State<WelcomeScreenController> createState() =>
      _WelcomeScreenControllerState();
}

class _WelcomeScreenControllerState extends State<WelcomeScreenController> {
  Widget? currentAppScreen;

  @override
  void initState() {
    currentAppScreen = WelcomeScreen(screenSwitcher);
    super.initState();
  }

  void screenSwitcher() {
    setState(() {
      currentAppScreen = LoginRegisterScreenController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainUserInterface(newScreenToRender: currentAppScreen);
  }
}
