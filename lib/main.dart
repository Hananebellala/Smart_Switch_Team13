import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
//import 'package:info_popup/info_popup.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:sms_v2/sms.dart';




void main() {
  runApp(Loginpage());
}
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--log in page --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/
class Loginpage extends StatelessWidget {
  @override
 
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        backgroundColor: Color(0xFFFFFAFA),
         resizeToAvoidBottomInset: false, // reglage de probleme de l ecran apres lancer le clavier 
          body:Column(
            children: [
                Stack( // (logo+message 'welcome back !)
                children: [
                     Logo(),
                     Message(message:'welcome back !',size:33),          
                     ],            
                   ),     
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child:   Stack( 
                             children: [
                                  Backimage(message:'images/background.png',taille:0.7),
                                   BoxLogin(),
                                   GoBack(),
                      
                      ],
                    ),
                  ),
                ],
            ),
        ),
    );
  }
}//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--page de sing up--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/

class Singup extends StatelessWidget {
  const Singup({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Color(0xFFFFFAFA),
         resizeToAvoidBottomInset: false, // reglage de probleme de l ecran apres lancer le clavier 
          body:Column(
            children: [
              Stack( // (logo+message 'welcome back !)
                children: [
                    Logo(),
                     Message(message:'Create an account',size:34),          
                     ],            
                   ),     
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    

                    child:   Stack( 
                             children: [
                                  Backimage(message:'images/background3.png',taille:0.7),
                                  BoxCreateaccount (),
                                   GoBack(),
                      
                      ],
                    ),
                  ),
                ],
            ),
        );
  }
}//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/


//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--Forgot password page --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/
class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Color(0xFFFFFAFA),
         resizeToAvoidBottomInset: false, // reglage de probleme de l ecran apres lancer le clavier 
          body:Column(
            children: [
              Stack( // (logo+message 'welcome back !)
                children: [
                      Logo(),
                     Message(message:'Forgot password',size:33),          

                     ],            
                   ), 
                 
                    SizedBox(height: MediaQuery.of(context).size.height * 0.071),
                     Container(
                                   width: MediaQuery.of(context).size.width,
                                   height: MediaQuery.of(context).size.height * 0.035,
                                  child:
                                   Message(message:'Enter your email, you will receive a link to',size:20),
                                     ),
                  
                    Container(
                                   width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.035,
                                     child:
                                   Message(message:' reset your password',size:20),
                                         ) ,   
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.55,
                    
                      child:   Stack( 
                             children: [
                                  Backimage(message:'images/background2.png',taille:0.55),
                                  BoxForgotpassword(),
                                   GoBack(),
                      
                      ],
                    ),
                  ),
                ],
            ),
        );
  }
}//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/




//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--home--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&/
class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   
    //backgroundColor: ,
    body:
    
    Column(children: [
       const SizedBox(height:40),
      Row(
        
        children: [
       Container(
        height:100 ,
        width: MediaQuery.of(context).size.width*0.6,
        child:  const  Column(
          children: [
            Text('good morning',
            style:TextStyle(
             fontSize: 25,
            )),
            Text('user',
            style:TextStyle(
             fontSize: 20,
            )),
          ],
        )),
        Container(
          height:100 ,
        width: MediaQuery.of(context).size.width*0.2 ,
          child: const  Icon(Icons.audiotrack, color: Colors.green, size: 30.0, )),

          Container(
          height:100 ,
        width: MediaQuery.of(context).size.width*0.2 ,
          child: const  Icon(Icons.audiotrack, color: Colors.green, size: 30.0, )),
      
      ],)
    ]),
    );
  }
}



//********************************************************boxLog in ********************************************************************* */
class BoxLogin extends StatelessWidget {
  const BoxLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
              top: (MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.45)/7,
             left: (MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*0.800)/2,
             child: Container(
                                              
                                             height:  MediaQuery.of(context).size.height*0.45,
                                              width: MediaQuery.of(context).size.width*0.800,
                                              decoration: BoxDecoration(
                                            //  color: const  Color.fromARGB(255, 213, 212, 212),//ta3i
                                             color:Color(0xFFFAF7FF), //t3 hanane
                                              borderRadius: BorderRadius.circular(20), // Coins arrondis du conteneur
                                              boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(255, 90, 89, 89).withOpacity(0.5), // Couleur et opacité de l'ombre
                                                     
                                                      spreadRadius: 5, // Étalement de l'ombre
                                                       blurRadius: 10, // Flou de l'ombre
                                                         offset:const  Offset(0, 3), // Décalage de l'ombre par rapport au conteneur
                                                         
                                                        ),
                                                     ],
                                                  ),
                                                 padding: const  EdgeInsets.all(20.0),
                                                 child:   const   Column(
                                                    children: [ 
                                                           SizedBox(height:40), 
                                                             Username(),
                                                            SizedBox(height:20),
                                                             Password(), 
                                                             SizedBox(height:20),
                                                             Login(), 
                                                             TextLien(),
                                                  ],
                                                ),
                                             
                            ),
    );
  }
}//************************************************************************************************************************************ */

//*********************************************back boutton **********************************************************************
class GoBack extends StatelessWidget {
  const GoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
                           left: 10,
                          bottom: 10,
                          child: TextButton(
                       
                           onPressed: () {
                              Navigator.pop(context); // Action pour revenir en arrière
                                           },
                             child:  const Text('< Back',
                             style:TextStyle(
                              color:Colors.black,
                               fontSize:20,
                             )),
            ),
          );
  }
}//************************************************************************************************************************************

//***************************************************** Logo -class************************************************************************** */
class Logo extends StatelessWidget {
  //const Logo({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return  Container(
                   
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child:  Image.asset('images/logo.png'),         
                                );
  }
}//********************************************************************************************************************************************** */


//***************************************************** message  -class************************************************************************** */
class Message extends StatelessWidget {
  //const Message ({super.key});
  final String message;
  final double size;
  Message ({required this.message,required this.size});


  @override
  Widget build(BuildContext context) {
    return  Positioned(
                      bottom:0,
                  
                       left: 0, 
                       right: 0,
                        child:
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Centrer horizontalement
                          children: [
                                        
                                            Text(
                                               message,
                                            
                                                 style:  TextStyle(
                                                        fontFamily: 'assets/Fonts/Poppins-Regular.ttf',
                                                         color:Colors.black,
                                                         fontSize:size,
                                              ),
                                          ),
                                     ],
                                 ),
                      );
                      }
}//********************************************************************************************************************************************* */


//*******************************************************-back ground image -class*************************************************************************
class Backimage extends StatelessWidget {
  //const Backimage({super.key});
  final String message;
  final double taille;
  Backimage ({required this.message,required this.taille});
// cet taille est un reel entre 0 et 1 pour controler le height de image la some avec cette taille et taille de logo doit etre egal a 1


  @override
  Widget build(BuildContext context) {
    return   Positioned(
                         bottom: 0,
                          left: 0,
                          top:0,
                          right:0,
                          child:
                            Container(
                               
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height *taille,
                                child: Image.asset(
                                        message,
                                          fit: BoxFit.fill,
                                        ),
                                       ),
                                     );
  }
}//*********************************************************************************************************************************************


//*****************************************************user name -class************************************************************************** */
class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final TextEditingController _controller = TextEditingController();
    bool _showMessage = false;
  @override
  Widget build(BuildContext context) {
    return   Stack(
      children:[
                              /* if (!_showMessage)
                                    const   Positioned(
                                       // top:0,
                                        bottom:0,
                                        child:  Text(
                                          'invalid user name ',
                                           style: TextStyle(color: Colors.red),
                                                                   ),
                                      ),*/
                                                     TextFormField(
                                                             // maxLength: 25,
                                                              
                                                              controller: _controller,
                                                               onChanged: (value) {
                                                                         setState(() {
                                                                            _showMessage = value.length  ==0 && value.length<50;//&& value.contains(RegExp(r'\d{3}'));
                                                                             });
                                                                               },
                                                                 decoration:   InputDecoration(
                                                                   filled: true,  //ttna7a
                                                                  fillColor:Color(0xFFFFFAFA), //la couler claire 
                                                                   // fillColor:Color.fromARGB(255, 113, 55, 212),

                                                                 hintText: '    user name', 
                                                                 labelText: 'user name ',
                                                                focusedBorder: OutlineInputBorder(
                                                                     borderSide:const BorderSide(color: Color(0xFF6900FF), width: 2.0), // Bordure en focus
                                                                                              borderRadius: BorderRadius.circular(10), // Coins arrondis du conteneur

                                                                        ),
                                                                enabledBorder: OutlineInputBorder(
                                                                     borderSide: const BorderSide(color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
                                                                       borderRadius: BorderRadius.circular(10), // Coins arrondis du conteneur

                                                                       ),
                  
                                                                  ),
                                                                      ),

                                                                
                                                                ],
                                                           );
                                                                
  }
}
//********************************************************************************************************************************************* */


//*****************************************************password-class************************************************************************** */
class Password extends StatefulWidget {
  const Password({super.key});
  @override
  State<Password> createState() => _PasswordState();
}
class _PasswordState extends State<Password> {
   final TextEditingController _controller = TextEditingController();
    bool _showMessage = false;
    final  int  minLength=12;
  @override
  Widget build(BuildContext context) {
    return 
     
         Stack(
            children: [

              if (_showMessage)
              const Positioned(
              bottom:0,
               child:  Text(
                '   invalid password (12 char at least )',
                style: TextStyle(color: Colors.red),
                           ),
             ),
          //////////////
              TextFormField(
                
                controller: _controller,
                 onChanged: (value) {
                  setState(() {
                    _showMessage = value.length  >0 && value.length < 12;//&& value.contains(RegExp(r'\d{3}'));
                  });
                },
                obscureText: true, // Masque le texte saisi
                decoration:    InputDecoration(
                 filled: true,  //ttna7a
                    fillColor:Color(0xFFFFFAFA),
                focusedBorder: OutlineInputBorder(
                    borderSide:const  BorderSide(color: Color(0xFF6900FF), width: 2.0), // Bordure en focus
                     borderRadius: BorderRadius.circular(10), // Coins arrondis du conteneur

                        ),
                        enabledBorder: OutlineInputBorder(
                        borderSide: const  BorderSide(color: Color.fromARGB(255, 100, 99, 99), width: 1.0), // Bordure inactive
                         borderRadius: BorderRadius.circular(10), // Coins arrondis du conteneur

                             ),
                  labelText: 'password',
                  hintText: 'password',
                ),
              ),
            ],
          );
        }
}
//******************************************************************************************************************************************/

//******************************************************log in boutton--*********************************************************************/
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
     // minWidth:200.00,
     //minWidth: double.infinity, // Ajuste la largeur du bouton à la largeur maximale

      height: 100.0, 
      child: ElevatedButton(
           style: ElevatedButton.styleFrom(
                  primary: const  Color(0xFF6900FF),// Couleur de fond du bouton
                 onPrimary: Colors.white, // Couleur du texte du bouton
                 minimumSize: Size(double.infinity, 50.0), // Ajuste la taille du bouton

        ),
            onPressed: () {

               Navigator.push(context, MaterialPageRoute(builder: (context) => home()));

            },
            child: const  Text('Log in'), // Texte du bouton
          ),
    ) ;
  }
}
//******************************************************************************************************************************************/


//******************************************************text-lien **********************************************************************/

class TextLien extends StatefulWidget {
  const TextLien({super.key});

  @override
  State<TextLien> createState() => _TextLienState();
}

class _TextLienState extends State<TextLien> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children:[
      Align(
          alignment: Alignment.centerRight,

        child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpassword()));
              },
                     child: const   Text(
                  ' Forgot password?',
                  style: TextStyle(
                    //color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
            ),
      ),
   const SizedBox(height:20), // box seperation 
    Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centrer horizontalement
         children: [
                  const Text('Need an account?'), // simple texte
                   InkWell(    // texte lien 
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Singup()));
                    },
                           child: const   Text(
                        ' Sing up',
                        style: TextStyle(
                          //color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                  ),
         ],
       ),
      ]
    );
  }
}
//******************************************************************************************************************************************/


//********************************************************box FOrgot password  ********************************************************************* */
class BoxForgotpassword extends StatelessWidget {
  const BoxForgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
              top: (MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.45)/7,
             left: (MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*0.800)/2,
             child: Container(
                                              
                                             height:  MediaQuery.of(context).size.height*0.25,
                                              width: MediaQuery.of(context).size.width*0.800,
                                              decoration: BoxDecoration(
                                             color:Color(0xFFFAF7FF), //t3 hanane
                                              borderRadius: BorderRadius.circular(20), // Coins arrondis du conteneur
                                              boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(255, 90, 89, 89).withOpacity(0.5), // Couleur et opacité de l'ombre
                                                      spreadRadius: 5, // Étalement de l'ombre
                                                       blurRadius: 10, // Flou de l'ombre
                                                         offset:const  Offset(0, 3), // Décalage de l'ombre par rapport au conteneur
                                                         
                                                        ),
                                                     ],
                                                  ),
                                                 padding: const  EdgeInsets.all(20.0),
                                                 child:   const   Column(
                                                    children: [ 
                                                            SizedBox(height:20), 
                                                            Mails(),
                                                            // Username(),
                                                              //SizedBox(height:20),
                                                             //Login(), 
                                                             //TextLien(),
                                                  ],
                                                ),
                                             
                            ),
    );
  }
}//************************************************************************************************************************************ */

class LienText2 extends StatefulWidget {
  const LienText2({super.key});

  @override
  State<LienText2> createState() => _LienText2State();
}

class _LienText2State extends State<LienText2> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centrer horizontalement
         children: [
                  const Text('Already have an account?'), // simple texte
                   InkWell(    // texte lien 
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Loginpage()));
                    },
                           child: const   Text(
                        ' Log in',
                        style: TextStyle(
                          //color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                  ),
         ],
       );
  }
}

//********************************************************box  create a account  ********************************************************************* */
class BoxCreateaccount extends StatelessWidget {
  const BoxCreateaccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
              top: (MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.45)/14,
             left: (MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*0.800)/2,
             child: Container(
                                              
                                             height:  MediaQuery.of(context).size.height*0.5,
                                              width: MediaQuery.of(context).size.width*0.800,
                                              decoration: BoxDecoration(
                                             color:Color(0xFFFAF7FF), //t3 hanane
                                              borderRadius: BorderRadius.circular(20), // Coins arrondis du conteneur
                                              boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(255, 90, 89, 89).withOpacity(0.5), // Couleur et opacité de l'ombre
                                                      spreadRadius: 5, // Étalement de l'ombre
                                                       blurRadius: 10, // Flou de l'ombre
                                                         offset:const  Offset(0, 3), // Décalage de l'ombre par rapport au conteneur
                                                         
                                                        ),
                                                     ],
                                                  ),
                                                 padding: const  EdgeInsets.all(20.0),
                                                 child:   const   Column(
                                                    children: [ 

                                                             Username(),
                                                            SizedBox(height:5),
                                                             Username(),
                                                             SizedBox(height:5),
                                                             Password(),
                                                             SizedBox(height:5),
                                                            Password(),
                                                             SizedBox(height:13),
                                                               Login(), 
                                                               SizedBox(height:13),
                                                              LienText2(),
                                                  ],
                                                ),
                                             
                            ),
    );
  }
}//************************************************************************************************************************************ */

//*****************************************************mail -class************************************************************************** */
class Mails extends StatefulWidget {
  const Mails({super.key});

  @override
  State<Mails> createState() => _MailsState();
}

class _MailsState extends State<Mails> {
  final TextEditingController _controller = TextEditingController();
    bool _showMessage = false;
     bool _affichage = false;
  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        Stack(
          children:[
                                  if (_affichage)
                                            const  Positioned(
                                                           //bottom: 0,
                                                            child: Text(
                                                                    'Adresse e-mail invalide',
                                                                 style: TextStyle(color: Colors.red),
                                                                       ),
                                                                    ),
          
                                                         TextFormField(
                                                                 keyboardType: TextInputType.emailAddress,
                                                                 validator: (value) {
                                                                    if (EmailValidator.validate(value ?? "")){
                                                                      setState(() {
                                                                               _showMessage = false; // Masquer le message d'erreur
                                                                                      });
                                                                                 return null; // L'e-mail est valide
                                                                                    } else {
                                                                                      setState(() {
                                                                                      _showMessage = true; // Masquer le message d'erreur
                                                                                        });
                                                                              return 'Veuillez entrer une adresse e-mail valide';
                                                                                     }
                                                                                       },
          //
                                                                  
                                                                  controller: _controller,
                                                                      decoration:   InputDecoration(
                                                                        fillColor:Color.fromARGB(255, 113, 55, 212),
        
                                                                     hintText: ' mail', 
                                                                     labelText: 'mail ',
                                                                    focusedBorder: OutlineInputBorder(
                                                                         borderSide:const BorderSide(color: Color(0xFF6900FF), width: 2.0), // Bordure en focus
                                                                                                  borderRadius: BorderRadius.circular(10), // Coins arrondis du conteneur
        
                                                                            ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                         borderSide: const BorderSide(color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
                                                                           borderRadius: BorderRadius.circular(10), // Coins arrondis du conteneur
        
                                                                           ),
                      
                                                                      ),
                                                                          ),
        
                                                                    
                                                                    ],
                                                               ),
                                                               SizedBox(height:20),
                                                          

                                                               
   ElevatedButton(
           style: ElevatedButton.styleFrom(
                  primary: const  Color(0xFF6900FF),// Couleur de fond du bouton
                 onPrimary: Colors.white, // Couleur du texte du bouton
                 minimumSize: Size(double.infinity, 50.0), // Ajuste la taille du bouton
           ),
       
            onPressed:() async {
  final Email email = Email(
    subject: 'Sujet de l\'e-mail',
    recipients: ['sellamimalak632@gmail.com'], // Adresse du destinataire
    body: 'Contenu du message',
  );

  try {
    await FlutterEmailSender.send(email);
   print('envoie avec ');

  } catch (error) {
    print('Erreur lors de l\'envoi de l\'e-mail : $error');
  }
},

         child: const  Text('Send'), // Texte du bouton
          ),
   

      ],
    );
                                                                
  }
}
//********************************************************************************************************************************************* */


