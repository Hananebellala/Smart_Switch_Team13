import 'package:flutter/material.dart';
import 'on_off_tv.dart';

/********************************************************box  ********************************************************************* */
class Box_tv extends StatelessWidget {
 // const Box({super.key});
       var on=true;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
                                                  
                                                 height: MediaQuery.of(context).size.width*0.4,
                                                  width: MediaQuery.of(context).size.width*0.4,
                                                  decoration: BoxDecoration(
                                                //  color: const  Color.fromARGB(255, 213, 212, 212),//ta3i
                                                 color:Color(0xFFFAF7FF), //t3 hanane
                                                  borderRadius: BorderRadius.circular(20), // Coins arrondis du conteneur
                                                  boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(255, 115, 114, 114).withOpacity(0.5), // Couleur et opacité de l'ombre
                                                          spreadRadius: 3, // Étalement de l'ombre
                                                           blurRadius: 10, // Flou de l'ombre
                                                             offset:const  Offset(0, 2), // Décalage de l'ombre par rapport au conteneur
                                                            ),
                                                         ],
                                                      ),
                                                     padding: const  EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                     child:   const   Column(
                                                        children: [ 
                                                              // SizedBox(height:40),
                                                          on_off_tv(), // qui va controler l icon on/off et envoyer des message a base de donenr 
                                                          SizedBox(height:8),
                                                          Row( // ligne de message 1
                                                            children: [
                                                             SizedBox(width:8),//pour ne pas etre coler
                                                              Align( alignment:Alignment.centerLeft,child: Text('Smart Tv',style:TextStyle(fontSize: 20)),  ),
                                                            ],
                                                          ) ,          
                                                          Row( // ligne de message 2
                                                            children: [
                                                             SizedBox(width:8),
                                                              Align(alignment:Alignment.centerLeft, child:Text('  condor',style:TextStyle(fontSize: 10)), ),
                                                            ],
                                                          ) ,                        
                                                                 
                                                                              ],
                                                                             ),
                                                 
                                
        ),
                SizedBox(height: 25,),

      ],
    );
  }
}//**