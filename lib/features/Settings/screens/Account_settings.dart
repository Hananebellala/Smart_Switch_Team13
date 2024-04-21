import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/goBack.dart';
import '../widgets/username.dart';
import '../widgets/changeloc.dart';
import '../widgets/changepass.dart';
import 'settings_page.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key});

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  late TextEditingController _usernameController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        // Wrap your Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 57), // Space from top
              const Row(
                children: [
                  GoBack(previousScreen: SettingsPage()), // GoBack widget
                  SizedBox(
                      width:
                          30), // Space between "Go Back" and "Account Settings"
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
                  _pickImage(context); // Pick image from gallery
                },
                child: Center(
                  child: Container(
                    width: 93, // Width of the image container
                    height: 93, // Height of the image container
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, // Shape of the container
                      image: DecorationImage(
                        image: AssetImage(
                          'images/user_male.png', // User's profile picture
                        ),
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 10), // Space before the "Edit profile picture" text
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
              const SizedBox(
                  height:
                      30), // Space before the "Edit profile information" text
              const Padding(
                padding: EdgeInsets.only(
                    left: 18), // Adjust the left padding as needed
                child: Text(
                  'Edit profile information',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500, // Medium
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 8), // Space before the containers
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      children: [
                        Username(controller: _usernameController),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height:
                      20), // Space before the "Edit profile information" text
              const Padding(
                padding: EdgeInsets.only(
                    left: 18), // Adjust the left padding as needed
                child: Text(
                  'Security',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500, // Medium
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 8), // Space before the containers
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: const Column(
                      children: [
                        ChangeLoc(),
                        SizedBox(
                            height: 30), // Add space between Name and Username
                        ChangePass(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(
                    left: 10), // Adjust the left padding as needed
                child: SizedBox(
                  height: 50,
                  width: 335, // Adjust height to match the password rectangle
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle image picker
  void _pickImage(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Image picked successfully, handle the image
    }
  }
}
