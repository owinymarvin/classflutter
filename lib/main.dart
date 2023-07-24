import 'package:firebase_core/firebase_core.dart';
import 'package:firstpro/firebase_options.dart';
import 'package:firstpro/pages/main_auth_Page.dart';
// import 'package:firstpro/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MechanicApp());
}

class MechanicApp extends StatelessWidget {
  const MechanicApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mechanic App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: MainAuthPage(),
    );
  }
}
