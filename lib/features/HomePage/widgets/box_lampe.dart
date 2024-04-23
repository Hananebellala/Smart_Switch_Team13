import 'package:flutter/material.dart';
import 'on_off_lampe.dart';
import '../screens/add_new_device.dart';
import '../widgets/ajouter_box.dart';

/********************************************************box  ********************************************************************* */
class Box_lampe extends StatelessWidget {
  final String name;
  final String Xcode;
  final Function() onDelete;
  Box_lampe({required this.name, required this.Xcode, required this.onDelete});
  var on = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => cancel_box(
                      onDelete: onDelete,
                    )));
      },
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              //  color: const  Color.fromARGB(255, 213, 212, 212),//ta3i
              color: Color(0xFFFAF7FF), //t3 hanane
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Colors.black,
                  width: 0.5), // Coins arrondis du conteneur
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0)
                      .withOpacity(0.25), // Couleur et opacité de l'ombre
                  // spreadRadius: 3, // Étalement de l'ombre
                  blurRadius: 4, // Flou de l'ombre
                  offset: const Offset(
                      0, 4), // Décalage de l'ombre par rapport au conteneur
                ),
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0)
                      .withOpacity(0.44), // Couleur et opacité de l'ombre
                  // spreadRadius: 3, // Étalement de l'ombre
                  blurRadius: 3, // Flou de l'ombre
                  offset: const Offset(
                      0, 2), // Décalage de l'ombre par rapport au conteneur
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                // SizedBox(height:40),
                on_off_lampe(
                    code:
                        Xcode), // qui va controler l icon on/off et envoyer des message a base de donenr
                const SizedBox(height: 8),

                Row(
                  // ligne de message 2
                  children: [
                    const SizedBox(width: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Smart light',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Black text
                          fontFamily: 'Poppins', // Medium Poppins font
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black, // Black text
                          fontFamily: 'Poppins', // Light Poppins font
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}//**


