import 'package:flutter/material.dart';
import '../../screens/scencepage.dart';
 // ignore: camel_case_types
 class Scence_boutton extends StatefulWidget {
  final String pathIcon ;
  const Scence_boutton({super.key,required this.pathIcon});

  @override
  State<Scence_boutton> createState() => _home_bouttonState();
}

// ignore: camel_case_types
class _home_bouttonState extends State<Scence_boutton> {
  @override
  Widget build(BuildContext context) {
    return    
      IconButton( onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const scencepage()));


       }, icon: Image.asset(widget.pathIcon,height: 25,width: 25,), )         
;
  }
}