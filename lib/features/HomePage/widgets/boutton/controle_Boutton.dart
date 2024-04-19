import 'package:flutter/material.dart';
import '../../screens/next_homepage.dart';

// ignore: camel_case_types
class Controle_boutton extends StatefulWidget {
  final String pathIcon;
  const Controle_boutton({super.key, required this.pathIcon});

  @override
  State<Controle_boutton> createState() => _home_bouttonState();
}

// ignore: camel_case_types
class _home_bouttonState extends State<Controle_boutton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const next_homepage()));
      },
      icon: Image.asset(
        widget.pathIcon,
        height: 25,
        width: 25,
      ),
    );
  }
}
