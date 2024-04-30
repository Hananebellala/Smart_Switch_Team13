import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smart_switch_team13/features/authentification/screens/signup_screen.dart';

class start extends StatelessWidget {
  const start({super.key});

  void _navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SignupScreen()), // Target page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background image
        Positioned(
          top: 330,
          left: 0,
          right: 0,
          child: Image.asset(
            'images/yellow3.png', // Background image
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height - 180,
          ),
        ),
        Positioned(
          top: 180,
          left: MediaQuery.of(context).size.width, // Start outside the screen
          child: Image.asset(
            'images/iphone11.png', // Asset to slide in
            width: 686.48,
            height: 490.78,
          )
              .animate(
                delay:
                    const Duration(milliseconds: 250), // Delay before animation
              )
              .slideX(
                begin: 0, // Slide from left to right
                end: -0.77, // Stop in the middle
                duration: const Duration(seconds: 1), // Animation duration
              ),
        ),
        Positioned(
          top: 90,
          left: MediaQuery.of(context).size.width, // Start outside the screen
          child: Image.asset(
            'images/iphone12.png', // Asset to slide in
            width: 686.48,
            height: 490.78,
          )
              .animate(
                delay:
                    const Duration(milliseconds: 250), // Delay before animation
              )
              .slideX(
                begin: -1.2, // Slide from left to right
                end: -0.79, // Stop in the middle
                duration: const Duration(seconds: 1), // Animation duration
              ),
        ),

        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 150, // Centered
          top: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50), // Space after the mobile image
              // Second text block
              const SizedBox(
                width: 315,
                height: 50,
                child: Text(
                  'Control devices within your room and create scenes that match your mood',
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
                  height: 50, // Adjusted height for rectangle
                  width: 200, // Adjusted width for rectangle
                  decoration: BoxDecoration(
                    color: const Color(0xFF6900FF), // Keep the color
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  child: const Center(
                    child: Text(
                      'start',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        height: 22 / 20,
                        color: Color.fromARGB(225, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
