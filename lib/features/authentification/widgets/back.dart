import 'package:flutter/material.dart';

class Backimage extends StatelessWidget {
  //const Backimage({super.key});
  final String message;
  final double taille;
  const Backimage({super.key, required this.message, required this.taille});
// cet taille est un reel entre 0 et 1 pour controler le height de image la some avec cette taille et taille de logo doit etre egal a 1

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      top: 0,
      right: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * taille,
        child: Image.asset(
          message,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
