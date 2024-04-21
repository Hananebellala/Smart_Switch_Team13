import 'package:flutter/material.dart';

class Username extends StatefulWidget {
  final TextEditingController controller;
  const Username({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE4D9FC),
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
        setState(() {}); // Trigger rebuild to maintain focus
      },
    );
  }
}

class Name extends StatefulWidget {
  final TextEditingController nameController;
  const Name({Key? key, required this.nameController});

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.nameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE4D9FC),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6900FF), width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Name',
        hintText: 'Enter your name',
        labelStyle:
            const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300),
      ),
      onChanged: (value) {
        setState(() {}); // Trigger rebuild to maintain focus
      },
    );
  }
}
