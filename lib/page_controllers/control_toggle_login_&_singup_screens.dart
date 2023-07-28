import 'package:flutter/material.dart';
import 'package:cartowingservice/pages/login_screen.dart';
import 'package:cartowingservice/pages/register_screen.dart';


class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
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
