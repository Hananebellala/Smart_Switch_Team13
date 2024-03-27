import 'package:flutter/material.dart';
import '../widgets/rectangle.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 57), // Space from top
            Text(
              'Account Settings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600, // SemiBold
                fontSize: 24.0, // Adjust the font size as needed
                color: Colors.black, // Black color
              ),
            ),
            SizedBox(height: 27), // Additional space
            Rectangle(),
          ],
        ),
      ),
    );
  }
}
