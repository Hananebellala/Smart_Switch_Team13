import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/message.dart';
import '../widgets/back.dart';

import '../widgets/box_forgot_password.dart';
import '../widgets/go_back.dart';

class ForgotPasswordScreen extends StatelessWidget {
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
              Message(message: 'Forgot password', size: 33),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.071),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.035,
            child: Message(
                message: 'Enter your email, you will receive a link to',
                size: 20),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.035,
            child: Message(message: ' reset your password', size: 20),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.559,
            child: Stack(
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
