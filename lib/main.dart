import 'package:firebase_core/firebase_core.dart';
import 'package:firstpro/firebase_options.dart';
import 'package:flutter/material.dart';
import 'main_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MechanicApp());
}

class MechanicApp extends StatelessWidget {
  MechanicApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mechanic App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainPage(),
    );
  }
}
