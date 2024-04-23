import 'package:flutter/material.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/home_boutton.dart';
import '../widgets/boutton/paramettre_boutton.dart';
import '../widgets/boutton/controle_Boutton.dart';
import '../widgets/boutton/scence_boutton.dart';
import 'next_homepage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.035),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.6,
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            'Good Morning,',
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: const Text(
                            'User',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      icon: const Icon(
                        Icons.notifications,
                        color: Color(0xFF6900FF),
                        size: 27.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const next_homepage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.001,
                  ),
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: Color(0xFF6900FF),
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const next_homepage(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 150),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment.centerLeft,
                  child: const Text('Connected Devices'),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const next_homepage(),
                        ),
                      );
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                
              ],
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF6900FF),
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const next_homepage(),
                ),
              );
            },
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
        shape: CircularNotchedRectangle(),
        child: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Home_boutton(pathIcon: 'icon/homeOn.ico'),
              SizedBox(width: 30),
              Controle_boutton(pathIcon: 'icon/controle.ico'),
              SizedBox(width: 90),
              Scence_boutton(pathIcon: 'icon/sCENCE_1.ico'),
              SizedBox(width: 30),
              Paramettre_boutton(pathIcon: 'icon/paramettre.ico'),
            ],
          ),
        ),
      ),
    );
  }
}
