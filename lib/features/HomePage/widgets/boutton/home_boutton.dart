import 'package:flutter/material.dart';
import '../../screens/homepage.dart';
 class Home_boutton extends StatefulWidget {
  final String pathIcon;
  const Home_boutton({Key? key,required this.pathIcon}) : super(key: key);

  @override
  State<Home_boutton> createState() => _Home_bouttonState();
}

class _Home_bouttonState extends State<Home_boutton> {
   @override
  Widget build(BuildContext context) {
    return    
      IconButton( onPressed: () {

        setState(() {
             Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          });

       }, icon: Image.asset(widget.pathIcon,height: 25,width: 25,), )         
;
  }
}