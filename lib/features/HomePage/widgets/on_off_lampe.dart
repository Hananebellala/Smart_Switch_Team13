import 'package:flutter/material.dart';
//*********************** on-off-Icon*****************
class on_off_lampe extends StatefulWidget {
  const on_off_lampe({super.key});
  
  @override
  State<on_off_lampe> createState() => _on_offState();
}

class _on_offState extends State<on_off_lampe> {
  @override
  String _lampe='icon/lampe.ico';
  bool on=false;
  Widget build(BuildContext context) {
    return  Row( children: [  // ligne de icon+bouton
                         Align(alignment:Alignment.centerLeft,child:Image.asset(_lampe,height: 65,width: 65,)),
                         const SizedBox(width:15),
                          const SizedBox(width:15),

                         Switch(
                          //activeColor: Color(0xFF6900FF),
                                value: on,
                               onChanged: (newValue) {
                               setState(() {
                                on= newValue;
                                if (on==true){
                                  _lampe='icon/lampeOn.ico';
                                }else{
                                  _lampe='icon/lampe.ico';
                                }
                                
                                 }); },)],) ; 
  }
}
//************************************* */ */