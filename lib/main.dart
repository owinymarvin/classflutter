import 'package:cartowingservice/page_controllers/control_welcome_to_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cartowingservice/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MainUserInterface(newScreenToRender: WelcomeScreenController()),
  );
}

class MainUserInterface extends StatelessWidget {
  const MainUserInterface({super.key, required this.newScreenToRender});

  final dynamic newScreenToRender;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Emergency App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
          child: newScreenToRender,
        ),
      ),
    );
  }
}
