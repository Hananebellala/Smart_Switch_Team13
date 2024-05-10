import 'package:flutter/material.dart';
import 'on_off_lampe.dart';
import '../screens/add_new_device.dart';
import '../widgets/ajouter_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

/********************************************************box  ********************************************************************* */
class Box_lampe extends StatelessWidget {
  final int Xid;
  final String etat;
  final String name;
  final String Xcode;
  final bool malak;
  final Function() onDelete;
  //final Function() update;
  Box_lampe(
      {required this.Xid,
      required this.etat,
      required this.name,
      required this.Xcode,
      required this.onDelete,
      required this.malak
      //required this.update
      });
  var on = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CancelBox1(onDelete: onDelete,)));
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
                  id: Xid,
                  code: Xcode,
                  isLampOn: etat == 'OFF' ? true : true,
                  lampIcon:
                      etat == 'OFF' ? 'icon/lampe.ico' : 'icon/lampeOn.ico',
                  malak: malak,
                ), // qui va controler l icon on/off et envoyer des message a base de donenr
                const SizedBox(height: 8),
                const Row(
                  children: [
                    SizedBox(width: 8), //pour ne pas etre coler
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('Smart light', style: TextStyle(fontSize: 22)),
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
}
