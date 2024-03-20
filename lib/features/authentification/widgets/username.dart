import 'package:flutter/material.dart';

class Username extends StatefulWidget {
  const Username({Key? key}) : super(key: key);

  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final TextEditingController _controller = TextEditingController();
  bool _showMessage = false;
  final int minLength = 12;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_showMessage)
          const Positioned(
            bottom: 0,
            child: Text(
              'Invalid password (minimum 12 characters)',
              style: TextStyle(color: Colors.red),
            ),
          ),
        TextFormField(
          controller: _controller,
          onChanged: (value) {
            setState(() {
              _showMessage = value.isNotEmpty && value.length < minLength;
            });
          },
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFFAFA),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF6900FF), width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Username',
            hintText: 'Enter your username',
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black.withOpacity(0.6), // Opacity 60%
              fontWeight: FontWeight.w300, // Light
            ),
          ),
        ),
      ],
    );
  }
}

class EmailField extends StatefulWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFFAFA),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6900FF), width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Email',
        hintText: 'Enter your email',
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: Colors.black.withOpacity(0.6), // Opacity 60%
          fontWeight: FontWeight.w300, // Light
        ),
      ),
    );
  }
}

class ConfirmPasswordField extends StatefulWidget {
  const ConfirmPasswordField({Key? key}) : super(key: key);

  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFFAFA),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6900FF), width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Confirm Password',
        hintText: 'Confirm your password',
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: Colors.black.withOpacity(0.6), // Opacity 60%
          fontWeight: FontWeight.w300, // Light
        ),
      ),
    );
  }
}
