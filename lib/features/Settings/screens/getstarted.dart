import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'helpCenter.dart';


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



class Feelit extends StatelessWidget {
  const Feelit({super.key});

  void _navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const start()), // Target page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background image
        Positioned(
          bottom: 320,
          left: 0,
          right: 0,
          child: Image.asset(
            'images/backyellow.png', // Background image
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height - 180,
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 187, // Center the image
          top: 50, // Position it above the animated content
          child: Image.asset(
            'images/Startled.png', // New image asset
            width: 355,
            height: 392,
          ),
        ),

        // Main column containing texts and button
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 150, // Centered
          top: 380,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20), // Space after the image

              // First text block
              const SizedBox(
                width: 271,
                height: 116,
                child: Text(
                  'Feel the\nserenity!',
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

              // Adjusted second text block with more height
              const SizedBox(
                width: 315,
                height: 80, // Increased height for full text visibility
                child: Text(
                  'Settle in and enjoy the comfort of your room, while effortlessly managing it all.',
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
              const SizedBox(height: 22), // Extra spacing between elements

              // Button for navigation
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
                delay:
                    const Duration(milliseconds: 250), // Delay before animation
              )
              .slideX(
                begin: -1.0, // Slide from left to right
                end: 0, // Stop in the middle
                duration: const Duration(seconds: 1), // Animation duration
              ),
        ),
        Positioned(
          top: 165,
          left: MediaQuery.of(context).size.width, // Start outside the screen
          child: Image.asset(
            'images/woman.png', // Asset to slide in
            width: 177.69,
            height: 201.85,
          )
              .animate(
                delay:
                    const Duration(milliseconds: 250), // Delay before animation
              )
              .slideX(
                begin: 0, // Slide from left to right
                end: -1.6, // Stop in the middle
                duration: const Duration(seconds: 1), // Animation duration
              ),
        ),
      ]),
    );
  }
}



class start extends StatelessWidget {
  const start({super.key});

  void _navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HelpCenter()), // Target page
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
