import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/HomePage/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

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
              const SnackBar(
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
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                    builder: (context) =>
                         Home()), // Replace HomeScreen() with the appropriate screen
              );
            } else {
              // Show an error message if authentication fails
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid email or password'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } catch (e) {
            // ignore: avoid_print
            print('Error signing in: $e');
            // Show an error message if authentication fails
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Error loging in. Please Enter your correct credentials.'),
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
} // Import your home screen widget

class SignupButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignupButton({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

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
          try {
            // Validate the form fields
            if (emailController.text.isEmpty ||
                usernameController.text.isEmpty ||
                passwordController.text.isEmpty ||
                confirmPasswordController.text.isEmpty) {
              throw 'All fields are required';
            }

            // Validate password and confirm password match
            if (passwordController.text != confirmPasswordController.text) {
              throw 'Passwords do not match';
            }

            // Create user with email and password using Firebase Authentication
            // ignore: unused_local_variable
            final UserCredential userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

            // Navigate to the home screen after successful signup
            Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                builder: (context) =>
                     Home(message :usernameController.text,test:true), // Replace Home() with your home screen widget
              ),
            );
          } on FirebaseAuthException catch (e) {
            // Handle FirebaseAuthException errors
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message ?? 'An error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          } catch (e) {
            // Handle other errors
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class SendButton extends StatefulWidget {
  final TextEditingController emailController;

  const SendButton({super.key, required this.emailController});

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          _sendPasswordResetEmail();
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

  Future<void> _sendPasswordResetEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: widget.emailController.text);
      // Show a success message or navigate to a confirmation screen
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent successfully')),
      );
    } catch (e) {
      // Handle errors such as invalid email or network issues
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending password reset email: $e')),
      );
    }
  }
}