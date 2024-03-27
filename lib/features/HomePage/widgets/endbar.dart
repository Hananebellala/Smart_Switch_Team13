import 'package:flutter/material.dart';

//********************************************************end bar ********************************************************************* */
class end_Bar extends StatelessWidget {
 // const Box({super.key});
       var on=true;

  @override
  Widget build(BuildContext context) {
    return  Container(
                                              
                                             height: MediaQuery.of(context).size.width*0.17,
                                              width: MediaQuery.of(context).size.width,
                                              alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                             color:Color(0xFFFAF7FF),
                                               borderRadius: const  BorderRadius.only(
                                               topLeft: Radius.circular(20), // Coin supérieur gauche
                                              topRight: Radius.circular(20), // Coin inférieur droit
                                                 ), //t3 hanane
                                               // Coins arrondis du conteneur
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
                                                           SizedBox(height:40),
                                                                            
                                                             
                                                                          ],
                                                                         ),
                                             
                            
    );
  }
}//*