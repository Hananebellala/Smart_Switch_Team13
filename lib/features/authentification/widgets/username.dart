import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Username extends StatefulWidget {
  final TextEditingController controller;
  const Username({Key? key, required this.controller});

  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();

  }

  
  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }


  Future<void> _saveUsername(String username) async {
    // Ouvrir la base de données
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, username TEXT)',
        );
      },
      version: 1,
    );


    // Insérer ou mettre à jour le nom d'utilisateur
    await database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT OR REPLACE INTO users(id, username) VALUES(?, ?)',
        [1, username],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
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
        labelStyle:
            const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300),
      ),
      onChanged: (value) {

        _saveUsername(value);
        // Update the value in the controller
        widget.controller.text = value;
        // Save the username to the database
        
        setState(() {}); // Trigger rebuild to maintain focus
      },
    );
  }
}


class EmailField extends StatefulWidget {
  final TextEditingController controller;
  const EmailField({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  late FocusNode _focusNode;
  late String _errorText; // Track the error text

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _errorText = ''; // Initialize error text
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    // Check if the entered text contains "@" symbol
    if (value == null || !value.contains('@')) {
      return 'Invalid email'; // Return error message if "@" is not found
    }
    return null; // Return null if validation succeeds
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
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
        labelText: 'Email',
        hintText: 'Enter your email',
        errorText: _errorText.isNotEmpty
            ? _errorText
            : null, // Show error text if not empty
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: widget.controller.text.isEmpty
              ? Colors.black.withOpacity(0.6)
              : Colors.black,
          fontWeight: FontWeight.w300, // Light
        ),
      ),
      onTap: () {
        _focusNode.requestFocus(); // Ensure focus is maintained
      },
      onChanged: (value) {
        // Validate email whenever text changes
        setState(() {
          _errorText = _validateEmail(value) ??
              ''; // Update error text based on validation result
        });
      },
    );
  }
}

class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController
      passwordController; // Add controller parameter for password field
  final TextEditingController controller; // Add controller parameter
  const ConfirmPasswordField(
      {super.key, required this.passwordController, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  late FocusNode _focusNode;
  bool _showMessage = false;
  bool _showPassword = false;
  late String _errorText;
  String _eyeIcon = 'images/eye.png'; // Track the error text

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _errorText = ''; // Initialize error text
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    // Check if the entered text is the same as the password
    if (value != widget.passwordController.text) {
      return 'Passwords do not match'; // Return error message if passwords do not match
    }
    return null; // Return null if validation succeeds
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller, // Use provided controller
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
        labelText: 'Confirm Password',
        hintText: 'Confirm your password',
        errorText: _errorText.isNotEmpty
            ? _errorText
            : null, // Show error text if not empty
        labelStyle:
            const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300),
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
      onTap: () {
        _focusNode.requestFocus(); // Ensure focus is maintained
      },
      onChanged: (value) {
        // Validate password whenever text changes
        setState(() {
          _errorText = _validatePassword(value) ??
              ''; // Update error text based on validation result
        });
      },
    );
  }
}
