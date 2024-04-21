import 'package:flutter/material.dart';
import '../../HomePage/widgets/boutton/controle_Boutton.dart';
import '../../HomePage/widgets/boutton/home_boutton.dart';
import '../../HomePage/widgets/boutton/paramettre_boutton.dart';
import '../widgets/goBack.dart';
import 'settings_page.dart';
import '../../HomePage/widgets/boutton/scence_boutton.dart';

class About extends StatelessWidget {
  const About({Key? key});

  @override
  Widget build(BuildContext context) {
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
                          60), // Space between "Go Back" and "Account Settings"
                  Text(
                    'About',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600, // SemiBold
                      fontSize: 24.0, // Adjust the font size as needed
                      color: Colors.black, // Black color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100), // Additional space
              const Text(
                'Lorem ipsum dolor sit amet consectetur. Euismod suspendisse sed maecenas in euismod elit senectus sit. Velit arcu volutpat parturient diam amet leo et. Pretium odio sed proin vitae at nunc mi etiam magnis. Amet convallis mauris habitant curabitur sagittis feugiat in diam sed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 60), // Additional space
              SizedBox(
                width: 224,
                height: 224,
                child: Image.asset(
                  'images/Smart_home_bro1.png',
                  fit: BoxFit.contain,
                ),
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
