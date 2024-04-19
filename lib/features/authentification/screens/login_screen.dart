import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/box_login.dart';
import '../widgets/back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/signup_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFAFA),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
