import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  const GoBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          '< Back',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
