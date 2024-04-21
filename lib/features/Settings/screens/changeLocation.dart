import 'package:flutter/material.dart';

import '../screens/ChangePassword.dart';
import '../../HomePage/widgets/boutton/controle_Boutton.dart';
import '../../HomePage/widgets/boutton/home_boutton.dart';
import '../../HomePage/widgets/boutton/paramettre_boutton.dart';
import '../../HomePage/widgets/boutton/scence_boutton.dart';
import '../widgets/goBack.dart';
import 'Account_settings.dart';

class ChangeLocation extends StatelessWidget {
  const ChangeLocation({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    double ffem = 1.0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xfffff9f9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GoBack(previousScreen: AccountSettings()), // GoBack widget
                        SizedBox(
                            width: 5), // Add some space between GoBack and Text
                        Expanded(
                          child: Container(
                            //margin: const EdgeInsets.fromLTRB(0, 0, 0, 34),
                            child: const Text(
                              'Change Location',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                height: 1,
                                letterSpacing: 0.15,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 10 * fem, 0 * fem, 30 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 347 * fem,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 15 * fem, 0 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          10 * fem, 20 * fem, 18 * fem, 9 * fem),
                      width: 340 * fem,
                      height: 55 * fem,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff000000)),
                        color: const Color(0xFFFAF7FF),
                        borderRadius: BorderRadius.circular(10 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x70000000),
                            offset: Offset(0 * fem, 2 * fem),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 10 * fem),
                            width: 40 * fem, // Increased size of the image
                            height: 40 * fem, // Increased size of the image
                            child: Image(
                              width: 400 * fem, // Increased size of the image
                              height: 400 * fem, // Increased size of the image
                              image: const AssetImage('images/search.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              textAlignVertical: TextAlignVertical
                                  .center, // Centered the hintText vertically
                              decoration: InputDecoration(
                                hintText: 'Search Address',
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12 * fem,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.06 * fem,
                                  color: const Color(0x99000000),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12 * fem,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.06 * fem,
                                color: const Color(0x99000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 377 * fem,
                height: 500 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * fem),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: -20 * fem,
                      bottom: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          heightFactor: 0.9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10 * fem),
                            child: Image.asset(
                              'images/Basemap.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20 *
                          fem, // Adjusted right position for the "Next" button
                      top: 350 *
                          fem, // Adjusted bottom position for the "Next" button
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChangePassword(),
                            ),
                          );
                        },
                        child: Container(
                          width: 340 * fem,
                          height: 50 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff6900ff),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1 * ffem / fem,
                                letterSpacing: 0.09 * fem,
                                color: const Color(0xfffff9f9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => next_homepage()));
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
          shape:
              CircularNotchedRectangle(), // quelle a fait border -aspace au dessous de bottom
          child: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Row(
              children: <Widget>[
                SizedBox(width: 10),
                Home_boutton(pathIcon: 'icon/home.ico'),
                SizedBox(width: 30),
                Controle_boutton(pathIcon: 'icon/controle.ico'),
                SizedBox(width: 90),
                Scence_boutton(pathIcon: 'icon/sCENCE_1.ico'),
                SizedBox(width: 30),
                Paramettre_boutton(pathIcon: 'icon/Setting.ico'),

                // ElevatedButton( onPressed: () {   }, child:Image.asset('icon/home.ico',height: 30,width: 30,) ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
