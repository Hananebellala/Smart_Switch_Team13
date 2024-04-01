import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/authentification/authentification.dart';
import 'package:smart_switch_team13/features/authentification/index.dart';
import 'login_button.dart';
import 'text_link.dart';
import 'username.dart';
import 'password.dart';

class BoxLogin extends StatefulWidget {
  const BoxLogin({Key? key}) : super(key: key);

  @override
  _BoxLoginState createState() => _BoxLoginState();
}

class _BoxLoginState extends State<BoxLogin> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.45) /
          7,
      left: (MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 0.800) /
          2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
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
        child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            EmailField(controller: _emailController),
            SizedBox(height: 20),
            Password(controller: _passwordController),
            SizedBox(height: 20),
            LoginButton(
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            SizedBox(height: 10),
            TextLink1(),
            SizedBox(height: 10),
            TextLink(),
          ],
        ),
        ),
      ),
    );
  }
}
