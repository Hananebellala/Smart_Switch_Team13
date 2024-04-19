import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errorMessage;
  final bool isLastPassword; // Indicator if it's the last password field
  final String correctLastPassword; // Correct last password from the database
  const Password({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.errorMessage,
    required this.isLastPassword,
    required this.correctLastPassword,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _showMessage = false;
  bool _showPassword = false;
  String _eyeIcon = 'images/eye.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_showMessage)
          Positioned(
            bottom: -20, // Adjust the position as needed
            child: Text(
              widget.errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor:
                const Color(0xFFE4D9FC), // Change background color to E4D9FC
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
            labelText: widget.labelText, // Use provided label text
            hintText: widget.hintText, // Use provided hint text
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
                duration: const Duration(milliseconds: 200),
                child: Transform.scale(
                  scale: 0.9,
                  child: ImageIcon(
                    AssetImage(_eyeIcon),
                  ),
                ),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _showMessage = value.isNotEmpty && value.length < 8;
            });
          },
        ),
        if (widget.isLastPassword) // Add condition for last password field
          Positioned(
            right: 10,
            bottom: -20,
            child: ElevatedButton(
              onPressed: () {
                _validateLastPassword(); // Validate last password when button is pressed
              },
              child: const Text('Save'),
            ),
          ),
      ],
    );
  }

  void _validateLastPassword() {
    if (widget.controller.text == widget.correctLastPassword) {
      // If the entered last password is correct
      // Perform the action here, like saving changes
      print('Last password is correct. Saving changes...');
    } else {
      setState(() {
        _showMessage = true; // Display error message
      });
    }
  }
}

class Password1 extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errorMessage;
  const Password1({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.errorMessage,
  });

  @override
  // ignore: library_private_types_in_public_api
  _Password1State createState() => _Password1State();
}

class _Password1State extends State<Password1> {
  final bool _showMessage = false;
  bool _showPassword = false;
  String _eyeIcon = 'images/eye.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_showMessage)
          Positioned(
            bottom: -20, // Adjust the position as needed
            child: Text(
              widget.errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor:
                const Color(0xFFE4D9FC), // Change background color to E4D9FC
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
            labelText: widget.labelText, // Use provided label text
            hintText: widget.hintText, // Use provided hint text
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
                duration: const Duration(milliseconds: 200),
                child: Transform.scale(
                  scale: 0.9,
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
