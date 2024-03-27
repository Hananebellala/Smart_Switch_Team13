import 'package:flutter/material.dart';
import '../../HomePage/screens/homepage.dart';


class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
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
          // Replace Home with an empty Container widget for now
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => home()),
          );
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

class SignupButton extends StatefulWidget {
  const SignupButton({Key? key}) : super(key: key);

  @override
  State<SignupButton> createState() => _SignupButtonState();
}

class _SignupButtonState extends State<SignupButton> {
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
          // Replace Home with an empty Container widget for now
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Container()),
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
