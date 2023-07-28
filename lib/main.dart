import 'package:cartowingservice/page_controllers/control_welcome_to_login_&_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cartowingservice/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MainUserInterface(newScreenToRender: WelcomeStartScreen()),
  );
}

class MainUserInterface extends StatelessWidget {
  const MainUserInterface({super.key, required this.newScreenToRender});

  final Widget newScreenToRender;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Emergency App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: newScreenToRender,
    );
  }
}
