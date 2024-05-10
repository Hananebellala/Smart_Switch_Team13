import 'package:flutter/material.dart';
import 'on_off_tv.dart';
import '../screens/add_new_device.dart';

/********************************************************box  ********************************************************************* */
// ignore: camel_case_types
class Box_tv extends StatelessWidget {
  // const Box({super.key});

  final int Xid;
  final String etat;
  final String name;
  final String Xcode;
  final bool malak;
  final Function() onDelete;
  //final Function(String) updateBoxetat;

  Box_tv(
      {required this.Xid,
      required this.etat,
      required this.name,
      required this.Xcode,
      required this.onDelete,
      //required this.updateBoxetat,
      required this.malak});
  final on = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CancelBox(onDelete: onDelete)));
      },
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7FF), // Light purple background
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Colors.black, width: 0.5), // Black border
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25), // Shadow 1
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.44), // Shadow 2
                  offset: const Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                On_off_tv(
                  id: Xid,
                  code: Xcode,
                  isActivated: etat == 'OFF' ? false : true,
                  tvIcon: etat == 'OFF' ? 'icon/tvOff.ico' : 'icon/tvOn.ico',
                  malak: malak,
                ), // Assuming you have defined this widget
                SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Smart TV',
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
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
