import 'package:flutter/material.dart';
import '../elements/cadre.dart';
import '../elements/info_box.dart';
import 'home_boutton.dart';
import 'paramettre_boutton.dart';
import 'controle_Boutton.dart';
import 'scence_boutton.dart';

// ignore: camel_case_types
class Add_scence extends StatefulWidget {
  const Add_scence({super.key});

  @override
  State<Add_scence> createState() => _home_bouttonState();
}

// ignore: camel_case_types
class _home_bouttonState extends State<Add_scence> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width * 0.8, 70),
        painter: DashedBorderPainter(),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 70,
          child: TextButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'icon/addition.ico',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 8),
                const Text(
                  ' Add New Device',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFA58BFF),
                    fontFamily: 'Poppins',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////
}

void _showBottomSheet(BuildContext context) {
  // ignore: non_constant_identifier_names
  String device_name = '';
  String paired_device = '';
  String device_type = '';

  void updateInputValue(String input, String newValue) {
    input = newValue;
  } // Mettre à jour la variable avec la nouvelle valeur

  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (BuildContext context) {
      return Scaffold(
        body: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            color: Colors
                .white, // Ajout de la couleur de fond pour mieux visualiser
            child: Column(
              children: [
                const SizedBox(height: 5),
                const Text('Add New Device', style: TextStyle(fontSize: 25)),
                const SizedBox(height: 15),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: const Text('Enter the device name'),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                      child: InfoBox(
                        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        initialValue: '',
                        onChanged: (newValue) {
                          updateInputValue(device_name, newValue);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: const Text('Select the device type'),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                      child: InfoBox(
                        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        initialValue: '',
                        onChanged: (newValue) {
                          updateInputValue(paired_device, newValue);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: const Text('Paired device'),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                      child: InfoBox(
                        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        initialValue: '',
                        onChanged: (newValue) {
                          updateInputValue(device_type, newValue);
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 50),
                        TextButton(
                          onPressed: () {
                            //   addBoxOnClick();
                          },
                          child: const Text(
                            'Add Device',
                            style: TextStyle(
                                fontSize: 15, color: Color(0xFF6900FF)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Row(
              children: [
                SizedBox(width: 10),
                Home_boutton(pathIcon: 'icon/home.ico'),
                SizedBox(width: 30),
                Controle_boutton(pathIcon: 'icon/controle.ico'),
                SizedBox(width: 90),
                Scence_boutton(pathIcon: 'icon/scenceON.ico'),
                SizedBox(width: 30),
                Paramettre_boutton(pathIcon: 'icon/paramettre.ico'),
              ],
            ),
          ),
        ),
      );
    },
  );
}
