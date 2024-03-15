import 'package:flutter/material.dart';
import 'logo.dart';
import 'message.dart';
import 'back.dart';
import 'go_back.dart';
import 'box_create_account.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFA),
      resizeToAvoidBottomInset:
          false, // reglage de probleme de l ecran apres lancer le clavier
      body: Column(
        children: [
          Stack(
            // (logo+message 'welcome back !)
            children: [
              Logo(),
              Message(message: 'Create an account', size: 34),
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
