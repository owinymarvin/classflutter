// import 'dart:math';

// import 'package:appusers/All_screens/login.dart';
// import 'package:appusers/All_screens/register.dart';
// import 'package:appusers/All_screens/login.dart';
import 'package:appusers/info_handler/app_info.dart';
import 'package:appusers/theme_provider/themeprovider.dart';
import 'package:appusers/welcome_screen/welcome.dart';
import 'package:appusers/widgets/pay_fare_amount_dialogue.dart';
// import 'package:appusers/welcome_screen/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'All_screens/homepage.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppInfo(),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}
