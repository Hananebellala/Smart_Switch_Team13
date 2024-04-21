import 'package:flutter/material.dart';
import '../widgets/rectangle5.dart';
import '../widgets/rectangle6.dart';
import '../widgets/rectangle7.dart';
import '../widgets/rectangle8.dart';

import '../../HomePage/widgets/boutton/controle_Boutton.dart';
import '../../HomePage/widgets/boutton/home_boutton.dart';
import '../../HomePage/widgets/boutton/paramettre_boutton.dart';
import '../../HomePage/widgets/boutton/scence_boutton.dart';
import 'settings_page.dart';
import '../widgets/goBack.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

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
    const imageYPercentage = 0.03; // Adjust as needed

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
              const Row(
                children: [
                  GoBack(previousScreen: SettingsPage()), // GoBack widget
                  SizedBox(
                      width:
                          30), // Space between "Go Back" and "Account Settings"
                  Text(
                    'Help Center',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600, // SemiBold
                      fontSize: 24.0, // Adjust the font size as needed
                      color: Colors.black, // Black color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 27), // Additional space
              const Rectangle5(),
              const SizedBox(height: 31), // Additional space
              const Rectangle6(),
              const SizedBox(height: 31), // Additional space
              const Rectangle7(),
              const SizedBox(height: 20), // Additional space
              const Rectangle8(),
              SizedBox(height: imageY), // Space to position the image
              Column(
                children: [
                  SizedBox(
                    width: imageSize.width,
                    height: imageSize.height,
                    child: Image.asset(
                      'images/Questions_bro.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                      height: 0), // Add space between the image and the button
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
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
