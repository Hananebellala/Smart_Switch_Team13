import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/rectangle.dart';
import '../widgets/rectangle2.dart';
import '../widgets/rectangle3.dart';
import '../widgets/rectangle4.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the device screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define the size of the image
    final imageSize = Size(183, 186.54);

    // Calculate the position of the image
    final imageX = (screenWidth - imageSize.width) / 2;

// Define the percentage of the screen height for the image position
    final imageYPercentage = 0.10; // Adjust as needed

// Calculate the position of the image
    final imageY = screenHeight * imageYPercentage;

    return Scaffold(
      backgroundColor: Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 57), // Space from top
            Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600, // SemiBold
                fontSize: 24.0, // Adjust the font size as needed
                color: Colors.black, // Black color
              ),
            ),
            SizedBox(height: 27), // Additional space
            Rectangle(),
            SizedBox(height: 31), // Additional space
            Rectangle2(),
            SizedBox(height: 31), // Additional space
            Rectangle3(),
            SizedBox(height: 31), // Additional space
            Rectangle4(),
            SizedBox(height: imageY), // Space to position the image
            Container(
              width: imageSize.width,
              height: imageSize.height,
              child: SvgPicture.asset(
                'images/Preferences-bro 1.svg',
                fit: BoxFit
                    .contain, // Ensure the image fits within the container
              ),
            ),
          ],
        ),
      ),
    );
  }
}
