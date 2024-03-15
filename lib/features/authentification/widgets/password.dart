import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final TextEditingController _controller = TextEditingController();
  bool _showMessage = false;
  final int minLength = 12;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_showMessage)
          Positioned(
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
              _showMessage = value.length > 0 && value.length < minLength;
            });
          },
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFFFFAFA),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF6900FF), width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Password',
            hintText: 'Enter your password',
            labelStyle:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
