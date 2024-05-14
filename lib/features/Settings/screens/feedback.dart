import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../widgets/goBack.dart';
import '../screens/helpCenter.dart';

class Feedback extends StatelessWidget {
  const Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(27, 20, 27, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 57), // Space from top
              const Row(
                children: [
                  GoBack(previousScreen: HelpCenter()), // GoBack widget
                  SizedBox(
                      width:
                          20), // Space between "Go Back" and "Account Settings"
                  Text(
                    'User Feedback',
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
                  'images/Feedback-bro 1.png',
                  width: 230,
                  height: 225,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: const Text(
                      'Rate switch it !',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.46,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    width: 307,
                    height: 48.94,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Center(
                      child: RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Image.asset(
                          'images/Star 2.png', // Path to your star image
                          width: 50, // Adjust width as needed
                          height: 50, // Adjust height as needed
                          semanticLabel: 'Star',
                        ),
                        onRatingUpdate: (rating) {
                          // ignore: avoid_print
                          print(rating);
                        },
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: const Text(
                      'Write your feedback',
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF3AB),
                      borderRadius: BorderRadius.circular(15.88),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.6,
                      ),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 307,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Submit',
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
    );
  }
}
