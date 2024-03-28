import 'package:flutter/material.dart';
import '../../screens/homepage.dart';
 class add_scence extends StatefulWidget {
  const add_scence({super.key});

  @override
  State<add_scence> createState() => _home_bouttonState();
}

class _home_bouttonState extends State<add_scence> {
 
  @override
  Widget build(BuildContext context) {
    return    
      IconButton( onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => home()));


       }, icon: Image.asset('icon/add.ico',height: 25,width: 25,), )         
;
  }
}