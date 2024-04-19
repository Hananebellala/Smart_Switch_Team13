import 'package:flutter/material.dart';
import '../screens/settings_page.dart';

class GoBack extends StatelessWidget {
  const GoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: TextButton(
        onPressed: () {
          Navigator.pop(
            context
          );
        },
        child: const Text(
          '< Back',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
