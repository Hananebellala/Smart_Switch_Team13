import 'package:flutter/material.dart';
import 'features/authentification/index.dart';
import 'features/Settings/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          LoginScreen(), // You can start with the login screen as the home screen
    );
  }
}
