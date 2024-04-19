import 'package:flutter/material.dart';
import '../../../Settings/screens/settings_page.dart';

// ignore: camel_case_types
class Paramettre_boutton extends StatefulWidget {
  final String pathIcon;
  const Paramettre_boutton({super.key, required this.pathIcon});

  @override
  State<Paramettre_boutton> createState() => _home_bouttonState();
}

// ignore: camel_case_types
class _home_bouttonState extends State<Paramettre_boutton> {
  bool a = false;
  int x = 0;
  int y = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SettingsPage()));
      },
      icon: Image.asset(
        widget.pathIcon,
        height: 25,
        width: 25,
      ),
    );
  }
}
