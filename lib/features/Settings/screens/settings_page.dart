import 'package:flutter/material.dart';



class Settings_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFFFAFA),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
             
            children: [
              SizedBox(height: 27),
              // Add your text at the top
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600, // SemiBold
                      fontSize: 20.0, // Adjust the font size as needed
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
