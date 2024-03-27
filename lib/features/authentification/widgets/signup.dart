import 'package:flutter/material.dart';
import 'logo.dart';
import 'message.dart';
import 'back.dart';
import 'go_back.dart';
import 'box_create_account.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      resizeToAvoidBottomInset:
          false, // reglage de probleme de l ecran apres lancer le clavier
      body: Column(
        children: [
          const Stack(
            // (logo+message 'welcome back !)
            children: [
              Logo(),
              Message(message: 'Create an account', size: 34),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Stack(
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
