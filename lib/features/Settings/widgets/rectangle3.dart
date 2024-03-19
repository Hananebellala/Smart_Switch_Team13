import 'package:flutter/material.dart';
import '../screens/Account_settings.dart';

class Rectangle3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the device screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the width of the Rectangle based on the screen width
    final containerWidth = screenWidth * 0.9; // 90% of screen width

    return GestureDetector(
      onTap: () {
        // Navigate to AccountSettings screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountSettings()),
        );
      },
      child: Container(
        width: containerWidth,
        height: 55,
        decoration: BoxDecoration(
          color: Color(0xFFFAF7FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xFF6900FF),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: containerWidth * 0.08), // 8% of container width
              child: Text(
                'Help Center',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/Vector.png', // Path to your image asset
                width: 24, // Maintain specified size
                height: 24, // Maintain specified size
              ),
            ),
            SizedBox(width: 12), // Maintain specified spacing
          ],
        ),
      ),
    );
  }
}
