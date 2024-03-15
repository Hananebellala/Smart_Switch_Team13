import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/message.dart';
import '../widgets/box_login.dart';
import '../widgets/go_back.dart';
import '../widgets/back.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFFFAFA),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Stack(
              children: [
                Logo(),
                Message(message: 'Welcome back !', size: 33),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Stack(
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
