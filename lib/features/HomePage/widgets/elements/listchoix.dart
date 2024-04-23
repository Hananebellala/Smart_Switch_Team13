import 'package:flutter/material.dart';


class Info extends StatefulWidget {
  final String initialValue;
  final Function(String) onChanged;


  const Info({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);


  @override
  _InfoState createState() => _InfoState();
}


class _InfoState extends State<Info> {
  late String _selectedOption;


  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialValue;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
             width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
      ),            child: DropdownButtonFormField<String>(
              value: _selectedOption,
              items: [
                DropdownMenuItem<String>(
                  value: 'TV',
                  child: Text('TV'),
                ),
                DropdownMenuItem<String>(
                  value: 'Lampe',
                  child: Text('Lampe'),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                  widget.onChanged(newValue);
                }
              },
               icon: Image.asset(
                  'icon/addition.ico',
                  height: 20,
                  width: 20,
                ),
            ),
          ),
        ),
     
      ],
    );
  }
}




