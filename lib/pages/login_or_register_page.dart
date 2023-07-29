import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'Register_screen.dart';

class loginOrRegisterPage extends StatefulWidget {
  const loginOrRegisterPage({super.key, required Null Function() onTap});

  @override
  State<loginOrRegisterPage> createState() => _loginOrRegisterPageState();
}

class _loginOrRegisterPageState extends State<loginOrRegisterPage> {
  bool showloginPage = true;

  //togle between login and register page
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
