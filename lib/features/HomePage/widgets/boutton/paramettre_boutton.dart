import 'package:flutter/material.dart';
import '../../../Settings/screens/settings_page.dart';
 class paramettre_boutton extends StatefulWidget {
  final String pathIcon;
  const paramettre_boutton({super.key,required this.pathIcon});

  @override
  State<paramettre_boutton> createState() => _home_bouttonState();
}

class _home_bouttonState extends State<paramettre_boutton> {
  bool a=false;
  int x=0;
  int y=0;
  
  @override
  Widget build(BuildContext context) {
    return    
      IconButton( 
        
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));


       }, icon: Image.asset(widget.pathIcon,
       height: 25 ,
       width:25,
      ), 
      )         
;
  }
}