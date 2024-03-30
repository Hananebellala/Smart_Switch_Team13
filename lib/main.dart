import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/Settings/index.dart';
import 'package:smart_switch_team13/features/HomePage/index.dart';
import 'package:smart_switch_team13/features/LogoPage/index.dart';
import 'package:smart_switch_team13/firebase_options.dart';
import 'features/authentification/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins', // Specify the Poppins font family directly
      ),
      home:
          const LoginScreen(), // Start with the settings page as the home screen
    );
  }
}
