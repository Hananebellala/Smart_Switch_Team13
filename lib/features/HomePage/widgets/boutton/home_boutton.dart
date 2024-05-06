import 'package:flutter/material.dart';
import '../../screens/homepage.dart';

// ignore: camel_case_types
class Home_boutton extends StatefulWidget {
  final String pathIcon;
  const Home_boutton({super.key, required this.pathIcon});

  @override
  State<Home_boutton> createState() => _Home_bouttonState();
}

// ignore: camel_case_types
class _Home_bouttonState extends State<Home_boutton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        });
      },
      icon: Image.asset(
        widget.pathIcon,
        height: 25,
        width: 25,
      ),
    );
  }
}
