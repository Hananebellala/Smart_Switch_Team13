import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/box_create_account.dart';
import '../widgets/go_back.dart';
import '../widgets/back.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            children: [
              Logo(),
              Positioned(
                top: MediaQuery.of(context).size.height *
                    0.25, // Adjust as needed
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal, // Regular
                      fontSize: 34,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Stack(
              children: [
                Backimage(message: 'images/background3.png', taille: 0.7),
                BoxCreateAccount(),
                GoBack(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
