import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  final Widget previousScreen; // Reference to the previous screen

  const GoBack({required this.previousScreen, Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
          Alignment.bottomLeft, // Align the widget to the bottom left corner
      margin:
          const EdgeInsets.only(left: 0, bottom: 0), // Add margin for spacing
      child: TextButton(
        onPressed: () {
          // Navigate to the previous screen (AccountSettings screen)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => previousScreen),
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
