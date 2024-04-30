import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smart_switch_team13/features/LogoPage/screens/Feelit.dart';


class GettingStarted extends StatelessWidget {
  const GettingStarted({super.key});

  void _navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Feelit()), // Target page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Image.asset(
              'images/yellow_first.png', // Background image
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height - 180,
            ),
          ),

          // Positioning the "Mobile.png" image separately
          Positioned(
            left:
                MediaQuery.of(context).size.width / 2 - 187, // Center the image
            top: 50, // Position it above the animated content
            child: Image.asset(
              'images/Mobile.png', // New image asset
              width: 355,
              height: 392,
            ),
          ),

          // Main column containing texts and button
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 150, // Centered
            top: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20), // Space after the mobile image

                // First text block
                const SizedBox(
                  width: 271,
                  height: 116,
                  child: Text(
                    'Switch it,\nAnywhere!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 42,
                      height: 58 / 48,
                      color: Color(0xFF6900FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Spacing between elements

                // Second text block
                const SizedBox(
                  width: 315,
                  height: 50,
                  child: Text(
                    'Simplify your space with effortless control.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      height: 22 / 18,
                      color: Color(0xBB000000),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Spacing between elements

                // Button
                InkWell(
                  onTap: () => _navigateToNextPage(context), // Action on click
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6900FF),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'images/Vector.png', // Image in the center of the button
                      ),
                    ),
                  ),
                ),
              ],
            )
                .animate(
                  delay: const Duration(
                      milliseconds: 250), // Delay before animation
                )
                .slideX(
                  begin: -1.0, // Slide from left to right
                  end: 0, // Stop in the middle
                  duration: const Duration(seconds: 1), // Animation duration
                ),
          ),
          // New image "char.png" that animates from right to middle
          Positioned(
            top: 165,
            left: MediaQuery.of(context).size.width, // Start outside the screen
            child: Image.asset(
              'images/char.png', // Asset to slide in
              width: 177.69,
              height: 201.85,
            )
                .animate(
                  delay: const Duration(
                      milliseconds: 250), // Delay before animation
                )
                .slideX(
                  begin: 0, // Slide from left to right
                  end: -1.25, // Stop in the middle
                  duration: const Duration(seconds: 1), // Animation duration
                ),
          ),
        ],
      ),
    );
  }
}