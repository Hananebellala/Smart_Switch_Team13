import 'package:flutter/material.dart';
import '../screens/helpCenter.dart';
import '../widgets/goBack.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    double ffem = 1.0;
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          // Wrap Column with SingleChildScrollView
          child: Container(
            margin: EdgeInsets.fromLTRB(27, 20, 27, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 57), // Space from top
                const Row(
                  children: [
                    GoBack(previousScreen: HelpCenter()), // GoBack widget
                    SizedBox(
                        width:
                            30), // Space between "Go Back" and "Account Settings"
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600, // SemiBold
                        fontSize: 24.0, // Adjust the font size as needed
                        color: Colors.black, // Black color
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Image.asset(
                    'images/Contact us-bro 1.png',
                    width: 260 * fem,
                    height: 255 * fem,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        'Enter your mail',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.46,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 307,
                      height: 48.94,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFBF3AB),
                        borderRadius: BorderRadius.circular(15.88),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.6,
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        'Enter your message',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.46,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 307,
                      height: 153,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      decoration: BoxDecoration(
                        color: Color(0xFFFBF3AB),
                        borderRadius: BorderRadius.circular(15.88),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.6,
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 307,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD700),
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Send',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6900FF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
