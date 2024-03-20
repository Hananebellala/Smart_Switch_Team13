import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/message.dart';
import '../widgets/back.dart';

import '../widgets/box_forgot_password.dart';
import '../widgets/go_back.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Stack(
            children: [
              Logo(),
              Message(message: 'Forgot password', size: 33),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.071),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.035,
            child: const Message(
                message: 'Enter your email, you will receive a link to',
                size: 20),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.035,
            child: const Message(message: ' reset your password', size: 20),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.559,
            child: const Stack(
              children: [
                Backimage(message: 'images/background2.png', taille: 0.55),
                BoxForgotPassword(),
                GoBack(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
