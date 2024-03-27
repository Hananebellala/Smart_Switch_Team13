import 'package:flutter/material.dart';
//*********************** on-off-Icon*****************
class on_off extends StatefulWidget {
  const on_off({super.key});
  
  @override
  State<on_off> createState() => _on_offState();
}

class _on_offState extends State<on_off> {
  @override
  bool on=true;
  //Color? Xcouleur = Colors.yellow;
  Widget build(BuildContext context) {
    return  Row( children: [  // ligne de icon+bouton
                         const Align(alignment:Alignment.centerLeft,child: Icon( Icons.flashlight_on,size: 60,  color: Colors.yellow)),
                         const SizedBox(width:23),
                         Switch(
                          //activeColor: Color(0xFF6900FF),
                                value: on,
                               onChanged: (newValue) {
                               setState(() {
                                on= newValue; }); },)],) ; 
  }
}
//************************************* */ */