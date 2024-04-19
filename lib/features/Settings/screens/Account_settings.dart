import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/goBack.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 57), // Space from top
            const Row(
              children: [
                GoBack(), // GoBack widget
                SizedBox(width: 30), // Space between "Go Back" and "Account Settings"
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
            const SizedBox(height: 40), // Additional space
            GestureDetector(
              onTap: () {
                // Implement image picker logic here
                _pickImage(context); // Pass BuildContext to the function
              },
              child: Container(
                alignment: Alignment.center,
                width: 93, // Width of the image container
                height: 93, // Height of the image container
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Shape of the container
                  image: DecorationImage(
                    image: AssetImage(
                        'images/user_male.png'), // User's profile picture
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
                child: const Placeholder(), // Placeholder image if user's profile picture is not available
              ),
            ),
            const SizedBox(height: 10), // Space before the "Edit profile picture" text
            const Align(
              alignment: Alignment.center,
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
            const SizedBox(height: 20), // Space before the "Edit profile information" text
            const Text(
              'Edit profile information',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500, // Medium
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20), // Space before the containers
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500, // Medium
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8), // Space between "Name" and "User Name"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF6900FF),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'User Name',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300, // Light
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

  // Function to handle image picker
  void _pickImage(BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Image picked successfully, handle the image
    }
  }
}
