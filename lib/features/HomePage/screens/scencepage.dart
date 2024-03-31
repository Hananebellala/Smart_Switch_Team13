import 'package:flutter/material.dart';

import '../widgets/boutton/home_boutton.dart';
import '../widgets/boutton/paramettre_boutton.dart';
import '../widgets/boutton/controle_Boutton.dart';
import '../widgets/boutton/scence_boutton.dart';
import '../widgets/boutton/add_scence.dart';
import '../widgets/ajouter_box.dart';


class scencepage extends StatefulWidget {
  const scencepage({super.key});

  @override
  State<scencepage> createState() => _scencepageState();
}

class _scencepageState extends State<scencepage> {
   /*List<int> firstColumnData =[];
   List<int> secondColumnData =[];
    void addBox(int newBoxNumber) {
    setState(() {
      if (firstColumnData.length <= secondColumnData.length) {
        firstColumnData.add(newBoxNumber);
      } else {
        secondColumnData.add(newBoxNumber);
      }
    });
  }*/
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.035),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.6,
                      alignment: Alignment.bottomLeft,
                      child: const Text('Scence', style: TextStyle(fontSize: 23)),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              Container(
                height: 40,
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 0.11,
                child: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  radius: 30,
                  child: IconButton(
                    icon: const Icon(Icons.notifications, color: Color(0xFF6900FF), size: 27.0),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.001),
                width: MediaQuery.of(context).size.width * 0.15,
                child: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  radius: 30,
                  child: IconButton(
                    icon: const Icon(Icons.person, color: Color(0xFF6900FF), size: 30.0),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
              //  MyWidget(),-----------------------++++++++++++++++++++++++++++++----------------------++++++++++++++++++++++4444444444444
              insert(),

                const SizedBox(height: 20),
                add_scence(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Color(0xFF6900FF),
            shape: CircleBorder(),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Image.asset(
                'icon/Microphone.ico',
                height: 50,
                width: 70,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        shape:  CircularNotchedRectangle(),
        child: PreferredSize(
          preferredSize:  Size.fromHeight(100.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10),
              home_boutton(pathIcon: 'icon/home.ico'),
              SizedBox(width: 30),
              controle_boutton(pathIcon: 'icon/controle.ico'),
              SizedBox(width: 90),
              scence_boutton(pathIcon: 'icon/scenceON.ico'),
              SizedBox(width: 30),
              paramettre_boutton(pathIcon: 'icon/paramettre.ico'),
            ],
          ),
        ),
      ),
    );
  }
}