import 'controllers/signup_controller.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LoginScreen();
        } else {
          return SignupScreen();
        }
      },
    );
  }
}
