import 'package:flutter/material.dart';
//*********************** on-off-Icon*****************
class on_off_tv extends StatefulWidget {
  const on_off_tv({super.key});
  
  @override
  State<on_off_tv> createState() => _on_offState();
}

class _on_offState extends State<on_off_tv> {
  @override
  String _tv='icon/tvOff.ico';
  bool on=false;
  Widget build(BuildContext context) {
    return  Row( children: [  // ligne de icon+bouton
                             const SizedBox(width:15),

                         Align(alignment:Alignment.centerLeft,child:Image.asset(_tv,height: 60,width: 60,)),
                         const SizedBox(width:15),
                         Switch(
                          //activeColor: Color(0xFF6900FF),
                                value: on,
                               onChanged: (newValue) {
                               setState(() {
                                on= newValue;
                                if (_tv=='icon/tvOff.ico'){
                                  _tv='icon/tvOn.ico';
                                }else{
                                  _tv='icon/tvOff.ico';
                                }
                                
                                 }); },)],) ; 
  }
}
//************************************* */ */