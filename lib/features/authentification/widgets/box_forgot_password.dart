import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/authentification/authentification.dart';

class BoxForgotPassword extends StatelessWidget {
  const BoxForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    return Positioned(
      top: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.45) /
          7,
      left: (MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 0.800) /
          2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
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
        child: Column(
          children: [
            SizedBox(height: 20),
            EmailField(controller: _emailController),
            SizedBox(height: 20),
            SendButton(),
          ],
        ),
      ),
    );
  }
}
