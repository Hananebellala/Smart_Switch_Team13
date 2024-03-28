import 'package:flutter/material.dart';
import '../../screens/scencepage.dart';
 class scence_boutton extends StatefulWidget {
  final String pathIcon ;
  const scence_boutton({super.key,required this.pathIcon});

  @override
  State<scence_boutton> createState() => _home_bouttonState();
}

class _home_bouttonState extends State<scence_boutton> {
  @override
  Widget build(BuildContext context) {
    return    
      IconButton( onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => scencepage()));


       }, icon: Image.asset(widget.pathIcon,height: 25,width: 25,), )         
;
  }
}