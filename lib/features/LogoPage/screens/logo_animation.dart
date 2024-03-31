import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogoAnimation extends StatelessWidget {
  const LogoAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFFAFA),
        child: Center(
          child: Stack(
            children: [
              // Image Widget
              Positioned.fill(
                child: Image.asset(
                  'images/Loading.png', // Provide path to your image asset
                  fit: BoxFit.cover, // Cover the entire container
                ),
              ),

              // Lottie Animation Widget
              Positioned(
                left: 10,
                right: 0,
                top: MediaQuery.of(context).size.height / 2 -
                    50, // Center vertically
                child: Lottie.asset(
                  'animation/loadin.json', // Provide path to your Lottie animation file
                  width: 200, // Adjust width according to your requirement
                  height: 150, // Adjust height according to your requirement
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
