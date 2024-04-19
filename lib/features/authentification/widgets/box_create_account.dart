import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/authentification/authentification.dart';
import 'package:smart_switch_team13/features/authentification/index.dart';

class BoxCreateAccount extends StatefulWidget {
  const BoxCreateAccount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BoxCreateAccountState createState() => _BoxCreateAccountState();
}

class _BoxCreateAccountState extends State<BoxCreateAccount> {
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 1) / 14,
      left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.800) / 2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
        child: Form(
          child: SingleChildScrollView(
          child: Column(
            children: [
              EmailField(controller: _emailController),
              const SizedBox(height: 15),
              Username(controller: _usernameController),
              const SizedBox(height: 15),
              Password(controller: _passwordController),
              const SizedBox(height: 15),
              ConfirmPasswordField(
                controller: _confirmPasswordController, // Add the passwordController parameter here
                passwordController: _passwordController, // Pass the passwordController parameter
              ),
              const SizedBox(height: 30),
              SignupButton(
                emailController: _emailController,
                usernameController: _usernameController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              const SizedBox(height: 25),
              const LienText2(),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
