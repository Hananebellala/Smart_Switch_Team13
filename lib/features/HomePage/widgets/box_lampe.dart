import 'package:flutter/material.dart';
import 'on_off_lampe.dart';

/********************************************************box  ********************************************************************* */
class Box_lampe extends StatelessWidget {
  const Box_lampe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: const Color(0xFFFAF7FF), // Light purple background
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 0.5), // Black border
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
          child: const Column(
            children: [
              on_off_lampe(), // Assuming you have defined this widget
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(width: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Smart light',
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
                      'Bedroom light',
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
    );
  }
}
