import 'package:flutter/material.dart';

import '../widgets/Password.dart'; // Import the Password widget

import '../../HomePage/widgets/boutton/controle_Boutton.dart';
import '../../HomePage/widgets/boutton/home_boutton.dart';
import '../../HomePage/widgets/boutton/paramettre_boutton.dart';
import '../../HomePage/widgets/boutton/scence_boutton.dart';

class ChangePassword extends StatelessWidget {
  final TextEditingController _lastPasswordController =
      TextEditingController(); // Controller for the last password
  final TextEditingController _newPasswordController =
      TextEditingController(); // Controller for the new password
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // Controller for the confirm password

  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the device screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define the size of the image
    const imageSize = Size(183, 186.54);

    // Calculate the position of the image
    final imageX = (screenWidth - imageSize.width) / 2;

    // Define the percentage of the screen height for the image position
    const imageYPercentage = 0.0007; // Adjust as needed

    // Calculate the position of the image
    final imageY = screenHeight * imageYPercentage;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 57), // Space from top
              const Text(
                'Change Password',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600, // SemiBold
                  fontSize: 24.0, // Adjust the font size as needed
                  color: Colors.black, // Black color
                ),
              ),
              const SizedBox(height: 100), // Additional space
              Password1(
                controller: _newPasswordController,
                labelText: 'New Password',
                hintText: 'Enter your new password',
                errorMessage:
                    'Invalid password (minimum 12 characters)', // Provide an error message
              ),
              const SizedBox(height: 31), // Additional space
              Password1(
                controller: _newPasswordController,
                labelText: 'New Password',
                hintText: 'Enter your new password',
                errorMessage:
                    'Invalid password (minimum 12 characters)', // Provide an error message
              ),
              const SizedBox(height: 31), // Additional space
              Password1(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                hintText: 'Confirm your new password',
                errorMessage:
                    'Passwords do not match', // Provide an error message
              ),
              const SizedBox(height: 40), // Additional space
              SizedBox(height: imageY), // Space to position the image
              Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 350, // Adjust height to match the password rectangle
                    child: ElevatedButton(
                      onPressed: () async {
                        // Implement password change logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF6900FF), // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Button border radius
                          side: const BorderSide(
                              color: Colors.white, width: 2), // Button border
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500, // Medium
                          fontSize: 18.0, // Adjust the font size as needed
                          color: Color(0xFFFFFAFA), // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF6900FF),
            shape: const CircleBorder(),
            onPressed: () {
              // Implement action for the floating action button
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Image.asset(
                'icon/Microphone.ico',
                height: 50,
                width: 70,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        shape:
            CircularNotchedRectangle(), // quelle a fait border -aspace au dessous de bottom
        child: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Home_boutton(pathIcon: 'icon/home.ico'),
              SizedBox(width: 30),
              Controle_boutton(pathIcon: 'icon/controle.ico'),
              SizedBox(width: 90),
              Scence_boutton(pathIcon: 'icon/sCENCE_1.ico'),
              SizedBox(width: 30),
              Paramettre_boutton(pathIcon: 'icon/Setting.ico'),
            ],
          ),
        ),
      ),
    );
  }
}
