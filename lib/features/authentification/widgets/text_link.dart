import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/authentification/authentification.dart';
import 'signup.dart';

class TextLink extends StatefulWidget {
  const TextLink({Key? key}) : super(key: key);

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Need an account?',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Signup()));
          },
          child: const Text(
            ' Sign up',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}

class TextLink1 extends StatefulWidget {
  const TextLink1({Key? key}) : super(key: key);

  @override
  _TextLink1State createState() => _TextLink1State();
}

class _TextLink1State extends State<TextLink1> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align text to the right
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
            );
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}

class LienText2 extends StatelessWidget {
  const LienText2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text(
            ' Log in',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
