import 'package:cartowingservice/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:cartowingservice/classes/check_user_authentication.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen(this.screenSwitcher, {super.key});

  final Function() screenSwitcher;

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
    return MainUserInterface(
      newScreenToRender: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'lib/images/welcome.svg',
              // colorFilter: const ColorFilter.mode(
              //   Colors.white,
              //   BlendMode.srcIn,
              // ),
              width: 280.0,
              semanticsLabel: 'welcome image',
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              'Car Towing Service',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 28.0,
              ),
            ),
            const SizedBox(
              height: 150.0,
            ),
            const Text(
              'Don\'t get stuck anymore',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            TextButton(
              onPressed: () {
                widget.screenSwitcher();
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
      ),
    );
  }
}
