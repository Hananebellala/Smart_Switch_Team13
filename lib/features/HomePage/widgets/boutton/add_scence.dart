import 'package:flutter/material.dart';
import '../elements/cadre.dart';
import '../elements/info_box.dart';
import 'package:flutter/material.dart';
import '../../screens/scencepage.dart';
import '../../screens/next_homepage.dart';

import 'home_boutton.dart';
import 'paramettre_boutton.dart';
import 'controle_Boutton.dart';
import 'scence_boutton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../elements/listchoix.dart';
import '../ajouter_box.dart';

class AddScence extends StatefulWidget {
  final List<Box> firstColumnData;
  final List<Box> secondColumnData;
  /*final List<dynamic> firstColumnData;
  final List<dynamic> secondColumnData;*/
  final Function(int, String, String, String) onPressed;
  final Function(String) updateDeviceName;
  final Function(String) updatePairedDevice;
  final Function(String) updateDeviceType;
  const AddScence({
    Key? key,
    required this.firstColumnData,
    required this.secondColumnData,
    required this.onPressed,
    required this.updateDeviceName,
    required this.updatePairedDevice,
    required this.updateDeviceType,
  }) : super(key: key);

  @override
  State<AddScence> createState() => _AddScenceState();
}

class _AddScenceState extends State<AddScence> {
  // Changer _home_bouttonState en _AddScenceState

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
              _showBottomSheet(
                  context); // Modifier pour appeler la fonction _showBottomSheet
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'icon/addition.ico',
                  height: 30,
                  width: 30,
                ),
                SizedBox(width: 8),
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

  void _showBottomSheet(BuildContext context) {
    String device_name = 'l';
    String paired_device = 'm';
    String device_type = 'h';

    String updateInputValue(String newValue) {
      return newValue;
    }

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Scaffold(
          body: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
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
                            initialValue: '',
                            onChanged: (newValue) {
                              device_name = updateInputValue(newValue);
                              print(device_name);
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
                          child: Info(
                            initialValue:
                                'TV', // Valeur initiale sélectionnée (TV ou Lampe)
                            onChanged: (newValue) {
                              device_type = updateInputValue(newValue);
                              print(device_type);
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
                            initialValue: '',
                            onChanged: (newValue) {
                              paired_device = updateInputValue(
                                  newValue); // Update the paired_device variable with the new value
                              print(paired_device);
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
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                            const SizedBox(width: 50),
                            TextButton(
                              onPressed: () {
                                final newBoxNumber =
                                    widget.firstColumnData.length +
                                        widget.secondColumnData.length +
                                        1;
                                widget.updateDeviceName(device_name);
                                widget.updatePairedDevice(paired_device);
                                widget.updateDeviceType(device_type);
                                widget.onPressed(newBoxNumber, device_type,
                                    device_name, paired_device);
                                _refreshScenePage(context);

//Navigator.push(context, MaterialPageRoute(builder: (context) => scencepage()));
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
                    ),
                  ),
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
}

void _refreshScenePage(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => next_homepage()));
}
