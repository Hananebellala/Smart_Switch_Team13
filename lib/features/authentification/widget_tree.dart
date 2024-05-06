import 'controllers/signup_controller.dart';
import 'screens/signup_screen.dart';
import 'package:smart_switch_team13/features/HomePage/index.dart';
import 'package:smart_switch_team13/features/LogoPage/screens/GettingStarted.dart';

import 'package:flutter/material.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Auth().currentUser;

    return MaterialApp(
      title: 'Authentication Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      home: user != null ?  Home() : const GettingStarted(),
    );
  }
}

