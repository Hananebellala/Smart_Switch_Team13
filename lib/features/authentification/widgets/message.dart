import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final double size;

  const Message({Key? key, required this.message, required this.size})
      : super(key: key);

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
              color: Colors.black,
              fontSize: size,
            ),
          ),
        ],
      ),
    );
  }
}
