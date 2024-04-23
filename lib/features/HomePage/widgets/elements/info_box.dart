import 'package:flutter/material.dart';


class InfoBox extends StatefulWidget {
  final String initialValue; // Valeur initiale
  final Function(String) onChanged; // Fonction de rappel pour la valeur modifiée


  const InfoBox({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);


  @override
  State<InfoBox> createState() => _InfoBoxState();
}


class _InfoBoxState extends State<InfoBox> {
  late TextEditingController _controller;
  late String _enteredText;


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _enteredText = widget.initialValue;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 227, 210, 249), // Couleur d'arrière-plan
        borderRadius: BorderRadius.circular(15), // Bordure arrondie
        border: Border.all(
          color: Colors.grey, // Couleur de la bordure
          width: 0.5, // Largeur de la bordure
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre avec opacité
            spreadRadius: 2, // Rayon de propagation de l'ombre
            blurRadius: 4, // Rayon de flou de l'ombre
            offset: const Offset(0, 1), // Décalage de l'ombre par rapport au conteneur
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          setState(() {
            _enteredText = value;
          });
          widget.onChanged(value); // Appeler la fonction de rappel avec la valeur modifiée
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10), // Ajouter un padding horizontal pour le texte saisi
        ),
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}




