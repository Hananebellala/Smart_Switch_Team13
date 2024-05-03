import 'package:flutter/material.dart';
import '../screens/contactus.dart';

class Rectangle7 extends StatelessWidget {
  const Rectangle7({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the device screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the width of the Rectangle7 based on the screen width
    final containerWidth = screenWidth * 0.9; // 90% of screen width

    return GestureDetector(
      onTap: () {
        // Navigate to AccountSettings screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactUs()),
        );
      },
      child: Container(
        width: containerWidth,
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF6900FF),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: containerWidth * 0.08), // 8% of container width
              child: const Text(
                'Contact Us',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/Vector.png', // Path to your image asset
                width: 24, // Maintain specified size
                height: 24, // Maintain specified size
              ),
            ),
            const SizedBox(width: 12), // Maintain specified spacing
          ],
        ),
      ),
    );
  }
}
