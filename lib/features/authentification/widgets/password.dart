import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final TextEditingController _controller = TextEditingController();
  bool _showMessage = false;
  bool _showPassword = false;
  final int minLength = 12;
  String _eyeIcon = 'images/eye.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_showMessage)
          const Positioned(
            bottom: 0,
            child: Text(
              'Invalid password (minimum 12 characters)',
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300),
            ),
          ),
        TextFormField(
          controller: _controller,
          onChanged: (value) {
            setState(() {
              _showMessage = value.isNotEmpty && value.length < minLength;
            });
          },
          obscureText: !_showPassword, // Toggle based on _showPassword
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFFAFA),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFF6900FF), width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Password',
            hintText: 'Enter your password',
            labelStyle: const TextStyle(
                fontFamily: 'Poppins', fontWeight: FontWeight.w300),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _showPassword = !_showPassword;
                  _eyeIcon =
                      _showPassword ? 'images/eye_hide.png' : 'images/eye.png';
                });
              },
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200), // Animation duration
                child: Transform.scale(
                  scale: 0.9, // Adjust icon size as needed
                  child: ImageIcon(
                    AssetImage(_eyeIcon),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
