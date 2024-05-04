import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../widgets/boutton/home_boutton.dart';
import '../widgets/boutton/paramettre_boutton.dart';
import '../widgets/boutton/controle_Boutton.dart';
import '../widgets/boutton/scence_boutton.dart';
import '../widgets/ajouter_box.dart';
import '../widgets/ajouter_box.dart';

//import '../widgets/essay.dart';
//import '../widgets/listescene.dart';


class scencepage extends StatefulWidget {
 


  const scencepage({super.key});    


  @override
  State<scencepage> createState() => _scencepageState();
}


class _scencepageState extends State<scencepage> {
   Future<void> _refreshData() async {
    }


   
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ColumnBloc(), // Créez une instance de votre bloc ici
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30),
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
                        child: const Text('Scene', style: TextStyle(fontSize: 23)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Container(
                  height: 40,
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width * 0.11,
                  child:
                      IconButton(
                      icon: Image.asset('icon/notifcations.ico',height: 25,width: 25,),
                      onPressed: () {},
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
                 
                Insert(show:true ,showButtons: false,showlist: false,),
                 //Insert3(),

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
      ),
    );
  }
}




