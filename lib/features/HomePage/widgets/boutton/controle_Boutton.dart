import 'package:flutter/material.dart';
import '../../screens/next_homepage.dart';
 class controle_boutton extends StatefulWidget {
  final String pathIcon;
  const controle_boutton({super.key,required this.pathIcon});

  @override
  State<controle_boutton> createState() => _home_bouttonState();
}

class _home_bouttonState extends State<controle_boutton> {
  @override
  Widget build(BuildContext context) {
    return    
      IconButton( onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => next_homepage()));


       }, icon: Image.asset(widget.pathIcon,height: 25,width: 25,), )         
;
  }
}