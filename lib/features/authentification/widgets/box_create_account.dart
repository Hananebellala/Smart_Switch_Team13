import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/authentification/authentification.dart';
import 'package:smart_switch_team13/features/authentification/index.dart';

class BoxCreateAccount extends StatelessWidget {
  const BoxCreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.55) /
          14,
      left: (MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 0.800) /
          2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.558,
        width: MediaQuery.of(context).size.width * 0.800,
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7FF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: const Column(
          children: [
            EmailField(),
            SizedBox(height: 15),
            Username(),
            SizedBox(height: 15),
            Password(),
            SizedBox(height: 15),
            ConfirmPasswordField(),
            SizedBox(height: 13),
            SignupButton(),
            SizedBox(height: 13),
            LienText2(),
          ],
        ),
      ),
    );
  }
}