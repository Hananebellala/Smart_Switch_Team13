import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/HomePage/screens/homepage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 100.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF6900FF),
          minimumSize: const Size(double.infinity, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          // Validate the form fields
          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
            // Show an error message if any field is empty
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Email and password are required'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          // Perform user authentication
          try {
            // Sign in the user with email and password
            final UserCredential userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

            // Check if the user exists in the database
            if (userCredential.user != null) {
              // Navigate to the home screen after successful login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        home()), // Replace HomeScreen() with the appropriate screen
              );
            } else {
              // Show an error message if authentication fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid email or password'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } catch (e) {
            print('Error signing in: $e');
            // Show an error message if authentication fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error loging in. Please Enter your correct credentials.'),
                backgroundColor: Color.fromARGB(255, 255, 0, 0),
              ),
            );
          }
        },
        child: const Text(
          'Log in',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Use Poppins Bold
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignupButton({
    Key? key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 100.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF6900FF),
          minimumSize: const Size(double.infinity, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Validate the form fields
          if (emailController.text.isEmpty ||
              usernameController.text.isEmpty ||
              passwordController.text.isEmpty ||
              confirmPasswordController.text.isEmpty) {
            // Show an error message if any field is empty
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('All fields are required'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          // Validate password and confirm password match
          if (passwordController.text != confirmPasswordController.text) {
            // Show an error message if passwords don't match
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Passwords do not match'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          // Implement your signup logic here
          // Example: Auth().createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

          // Navigate to the next screen after successful signup
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    home()), // Replace NextScreen() with the appropriate screen
          );
        },
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Use Poppins Bold
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class SendButton extends StatefulWidget {
  const SendButton({Key? key}) : super(key: key);

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 100.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF6900FF),
          minimumSize: const Size(double.infinity, 50.0),
        ),
        onPressed: () {
          // Replace Home with an empty Container widget for now
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Container()),
          );
        },
        child: const Text(
          'Send',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Use Poppins Bold
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
