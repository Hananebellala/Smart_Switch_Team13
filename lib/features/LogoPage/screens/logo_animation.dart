import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_switch_team13/features/LogoPage/screens/GettingStarted.dart';
import 'package:smart_switch_team13/features/authentification/widget_tree.dart';

class LogoAnimation extends StatefulWidget {
  const LogoAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LogoAnimationState createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation> {
  @override
  void initState() {
    super.initState();
    // Schedule the navigation to the next screen after 10 seconds
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const WidgetTree(), // Define your next screen here
        ),
      );
    });
  }

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
