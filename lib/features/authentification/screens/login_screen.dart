import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/box_login.dart';
import '../widgets/go_back.dart';
import '../widgets/back.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFAFA),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Stack(
              children: [
                const Logo(),
                Positioned(
                  top: MediaQuery.of(context).size.height *
                      0.25, // Adjust as needed
                  left: 0,
                  right: 0,
                  child: const Center(
                    child: Text(
                      'Welcome back !',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal, // Regular
                        fontSize: 33,
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
                  Backimage(message: 'images/background.png', taille: 0.7),
                  BoxLogin(),
                  GoBack(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
