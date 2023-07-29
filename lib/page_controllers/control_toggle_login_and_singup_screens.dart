import 'package:flutter/material.dart';
import 'package:cartowingservice/pages/login_screen.dart';
import 'package:cartowingservice/pages/register_screen.dart';

class LoginRegisterScreenController extends StatefulWidget {
  const LoginRegisterScreenController({super.key});

  @override
  State<LoginRegisterScreenController> createState() =>
      _LoginRegisterScreenControllerState();
}

class _LoginRegisterScreenControllerState
    extends State<LoginRegisterScreenController> {
  bool showloginPage = true;

  void togglepages() {
    setState(() {
      showloginPage = !showloginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginPage) {
      return LoginScreen(
        onTap: togglepages,
      );
    } else {
      return RegisterScreen(
        onTap: togglepages,
      );
    }
  }
}
