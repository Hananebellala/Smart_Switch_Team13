import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/rectangle.dart';
import '../widgets/rectangle3.dart';
import '../widgets/rectangle4.dart';

import '../../HomePage/widgets/boutton/controle_Boutton.dart';
import '../../HomePage/widgets/boutton/home_boutton.dart';
import '../../HomePage/widgets/boutton/paramettre_boutton.dart';
import '../../HomePage/widgets/boutton/scence_boutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_switch_team13/features/authentification/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the device screen width and height

    final screenHeight = MediaQuery.of(context).size.height;

    // Define the size of the image
    const imageSize = Size(183, 186.54);

    // Calculate the position of the image

// Define the percentage of the screen height for the image position
    const imageYPercentage = 0.05; // Adjust as needed

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
                'Settings',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600, // SemiBold
                  fontSize: 24.0, // Adjust the font size as needed
                  color: Colors.black, // Black color
                ),
              ),
              const SizedBox(height: 27), // Additional space
              const Rectangle(),
              const SizedBox(height: 31), // Additional space
              const Rectangle3(),
              const SizedBox(height: 31), // Additional space
              const Rectangle4(),
              SizedBox(height: imageY), // Space to position the image
              Column(
                children: [
                  SizedBox(
                    width: imageSize.width,
                    height: imageSize.height,
                    child: SvgPicture.asset(
                      'images/Preferences-bro 1.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                      height: 0), // Add space between the image and the button
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        // Redirect the user to the login screen or any other screen
                        // For example:
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      } catch (e) {
                        print('Error logging out: $e');
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                        // Handle any errors that occur during logout
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF6900FF), // Button background color
                      minimumSize: const Size(139, 39), // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Button border radius
                        side: BorderSide(
                            color: Colors.white, width: 2), // Button border
                      ),
                    ),
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500, // Medium
                        fontSize: 16.0, // Adjust the font size as needed
                        color: Color(0xFFFFFAFA), // Text color
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
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => next_homepage()));
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

              // ElevatedButton( onPressed: () {   }, child:Image.asset('icon/home.ico',height: 30,width: 30,) ),
            ],
          ),
        ),
      ),
    );
  }
}
