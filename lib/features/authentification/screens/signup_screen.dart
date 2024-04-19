import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/box_create_account.dart';
import '../widgets/back.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            children: [
              const Logo(),
              Positioned(
                top: MediaQuery.of(context).size.height *
                    0.2, // Adjust as needed
                left: 0,
                right: 0,
                child: const Center(
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Stack(
              children: [
                Backimage(message: 'images/background3.png', taille: 0.7),
                BoxCreateAccount(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
