import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/boutton/home_boutton.dart';
import '../widgets/boutton/paramettre_boutton.dart';
import '../widgets/boutton/controle_Boutton.dart';
import '../widgets/boutton/scence_boutton.dart';

import '../widgets/ajouter_box.dart';

//import '../widgets/essay.dart';

class next_homepage extends StatefulWidget {
  const next_homepage({super.key});

  @override
  State<next_homepage> createState() => _next_homepageState();
}

class _next_homepageState extends State<next_homepage> {
  Future<void> _refreshData() async {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(), // Créez une instance de votre bloc ici
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFAFA),
        body: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.035),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          'Connected Devices',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Insert(),
                  // Insert2(),
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
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Home_boutton(pathIcon: 'icon/home.ico'),
                  SizedBox(width: 30),
                  Controle_boutton(pathIcon: 'icon/controleOn.ico'),
                  SizedBox(width: 90),
                  Scence_boutton(pathIcon: 'icon/sCENCE_1.ico'),
                  SizedBox(width: 30),
                  Paramettre_boutton(pathIcon: 'icon/paramettre.ico'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
