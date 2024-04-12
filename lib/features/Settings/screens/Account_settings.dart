import 'package:flutter/material.dart';
import '../widgets/rectangle.dart';
import '../widgets/goBack.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 57), // Space from top
            Row(
              children: [
                GoBack(), // GoBack widget
                SizedBox(
                  width: 30,
                ), // Space between "Go Back" and "Account Settings"
                Text(
                  'Account Settings',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600, // SemiBold
                    fontSize: 24.0, // Adjust the font size as needed
                    color: Colors.black, // Black color
                  ),
                ),
              ],
            ),
            SizedBox(height: 40), // Additional space
            SizedBox(width: 16), // Space before the circle
            // Circle and text
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: CircleAvatar(
                    radius: 93 / 2, // Radius of the circle
                    // You can provide the user's profile picture here
                    backgroundImage: AssetImage('images/user_male.png'),
                    // Placeholder image if user's profile picture is not available
                    child: Placeholder(),
                  ),
                ),
                Positioned(
                  bottom: -9, // Positioned 9 pixels below the circle
                  child: Text(
                    'Edit profile picture',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500, // Medium
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
