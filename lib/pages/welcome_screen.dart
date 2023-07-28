import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:cartowingservice/classes/check_user_authentication.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen(this.welcomeLoginScreenSwitcher, {super.key});

  final Function() welcomeLoginScreenSwitcher;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  /*
  @override
  void initState() {
    super.initState();
    CheckUserAuth.checkLoginStatus(context);
  }
  */

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'lib/images/welcome.svg',
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            width: 280.0,
            semanticsLabel: 'A red up arrow',
          ),
          const SizedBox(
            height: 40.0,
          ),
          const Text(
            'Car Towing Service',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
            ),
          ),
          const SizedBox(
            height: 150.0,
          ),
          const Text(
            'Don\'t get stuck anymore',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(
            height: 18.0,
          ),
          TextButton(
            onPressed: () {
              widget.welcomeLoginScreenSwitcher();
            },
            child: const Text(
              'Get Started',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}
