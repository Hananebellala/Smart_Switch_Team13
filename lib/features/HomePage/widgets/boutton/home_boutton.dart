import 'package:flutter/material.dart';
import '../../screens/homepage.dart';
 class home_boutton extends StatefulWidget {
  final String pathIcon;
  const home_boutton({Key? key,required this.pathIcon}) : super(key: key);

  @override
  State<home_boutton> createState() => _home_bouttonState();
}

class _home_bouttonState extends State<home_boutton> {
   @override
  Widget build(BuildContext context) {
    return    
      IconButton( onPressed: () {

        setState(() {
             Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
          });

       }, icon: Image.asset(widget.pathIcon,height: 25,width: 25,), )         
;
  }
}