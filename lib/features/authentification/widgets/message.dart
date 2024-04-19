import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final double size;

  const Message({super.key, required this.message, required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: size,
            ),
          ),
        ],
      ),
    );
  }
}
