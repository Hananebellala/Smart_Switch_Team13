
import 'package:flutter/material.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/home_boutton.dart';
import '../widgets/boutton/paramettre_boutton.dart';
import '../widgets/boutton/controle_Boutton.dart';
import '../widgets/boutton/scence_boutton.dart';

import 'next_homepage.dart';
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--home--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/
class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
   
    //backgroundColor: ,
    body: Column(children: [
       const SizedBox(height:25),
      Row( 
               children: [
              Container(
                    //color:Colors.blue,
                     padding:EdgeInsets.only(left:MediaQuery.of(context).size.width*0.035),
                    child:    
                    Column(
                    children: [
                            Container(
                                 height:50,
                               width: MediaQuery.of(context).size.width*0.6,
                                alignment: Alignment.bottomLeft, // this line is soooooooooo helpfull alignement de message dans un container 
                                child:  const Text('Good Morning,',
                                 style: TextStyle(
               // fontFamily:'assets/Fonts/Poppins-Regular.ttf',
                               fontSize: 23,
                                    )),
                                  ),
                           Container(
                                 height:30,
                                  width: MediaQuery.of(context).size.width*0.6,
                                     child:  const Text('User',
                                    style:TextStyle(
                                      fontSize: 20,
                                      )),
                                      ),
                                       ],
                                     )),
                            SizedBox(width: MediaQuery.of(context).size.width*0.1 ),
                            Container(
                                     height:40 ,
                                     alignment: Alignment.bottomCenter,
                                    // padding:EdgeInsets.only(right:MediaQuery.of(context).size.width*0.035),
                                        width: MediaQuery.of(context).size.width*0.11 ,
                                    child: CircleAvatar(
                                       backgroundColor: Colors.yellow, // Couleur de fond du cercle
                                      radius: 30,
                                      child: IconButton(
                                         icon: const  Icon(Icons.notifications, color: Color(0xFF6900FF), size: 27.0, ),
                                         onPressed:(){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>next_homepage()));  // lazm tkon t3 notification 
                                            } ,),
                                    ),),
                             Container(
                                     height:40 ,
                                     alignment: Alignment.bottomCenter,
                                     padding:EdgeInsets.only(right:MediaQuery.of(context).size.width*0.001),
                                        width: MediaQuery.of(context).size.width*0.15,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.yellow, // Couleur de fond du cercle
                                      radius: 30,
                                      child: IconButton(
                                         icon: const  Icon(Icons.person, color: Color(0xFF6900FF), size: 30.0, ),
                                         onPressed:(){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => next_homepage())); // lzm tkon t3 info personal 
                                            } ,),
                                    ),)
                                         ] ,),
        const  SizedBox(height:150),
        Row( 
              children:[ 
                                   SizedBox( width: MediaQuery.of(context).size.width*0.05 ),
                                   Container(
                                                 height:50,
                                                  width: MediaQuery.of(context).size.width*0.45 ,
                                                   alignment: Alignment.centerLeft,
                                                  child: const  Text ('Connected Devices')
                                                     ),
                                    Container(
                                       height:50,
                                       width: MediaQuery.of(context).size.width*0.45 ,
                                       alignment: Alignment.centerRight,
                                      
                                        child: InkWell(
                                                        onTap: () {
                                                                   Navigator.push(context, MaterialPageRoute(builder: (context) => next_homepage()));
                                                                  },
                                                        child: const   Text(
                                                       'See all',
                                                         style: TextStyle(
                                                        decoration: TextDecoration.underline,
                                                            ),
                                                          ),
                                                            ),
                                      
                                    ),
                                   

              ]
          ),
          SizedBox( height: 10 ),
         Row(
                         children: [
                                   SizedBox(width:MediaQuery.of(context).size.width*0.05),
                                   Box_lampe(),
                                   SizedBox(width:MediaQuery.of(context).size.width*0.1),
                                  Box_tv(),
                                     ],
                                     ),
                                  const  SizedBox(height:35),
         Row(
                        children: [
                                        SizedBox(width:MediaQuery.of(context).size.width*0.05),
                                        Box_lampe(),
                                          ],
                                         ),
                                            //  Stack(children: [
                                                   // end_Bar()]),
    ],),
    floatingActionButton: Container(
                                            height: 65.0,
                                              width: 65.0,
                                              child: FittedBox(
                                                        child: FloatingActionButton(
                                                          backgroundColor: Color(0xFF6900FF),
                                                         shape: CircleBorder(),
                                                        onPressed: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => next_homepage()));

                                                        },
                                                        child:Padding(
                                                          padding: const EdgeInsets.only(left:7),
                                                          child: Image.asset('icon/Microphone.ico',height: 50,width: 70,),
                                                        ), ), ),),
                                                        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      
        bottomNavigationBar:  const  BottomAppBar(
          
                                              shape:CircularNotchedRectangle(), // quelle a fait border -aspace au dessous de bottom
                                              child:  PreferredSize(
                                                  preferredSize: Size.fromHeight(100.0),
                                                     child: Row(
                                                              children: <Widget>[
                                                                SizedBox(width:10),
                                                               home_boutton(pathIcon:'icon/homeOn.ico')  ,  
                                                                  SizedBox(width:30),
                                                                controle_boutton(pathIcon:'icon/controle.ico')  ,  
                                                                SizedBox(width:90),
                                                               scence_boutton(pathIcon:'icon/sCENCE_1.ico')  , 
                                                                 SizedBox(width:30),                                                              
                                                                  paramettre_boutton(pathIcon:'icon/paramettre.ico')  ,  


                                                            // ElevatedButton( onPressed: () {   }, child:Image.asset('icon/home.ico',height: 30,width: 30,) ),
                                                              ],),

                                              ), ),
                                              );                       
      
  }
}
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&