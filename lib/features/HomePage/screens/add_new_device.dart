import 'package:flutter/material.dart';
 import '../widgets/ajouter_box.dart';
  class cancel_box extends StatefulWidget {
  final Function() onDelete;
   cancel_box({required this.onDelete});


  @override
  State<cancel_box> createState() => _cancel_boxState();
}


class _cancel_boxState extends State<cancel_box> {
  @override
  Widget build(BuildContext context) {
    return
       Column(
          crossAxisAlignment: CrossAxisAlignment.center,


        children: [
          SizedBox(height:250),
        Center(
          child: ElevatedButton(
          onPressed: () {
              widget.onDelete(); // Appel de la fonction onDelete
              Navigator.pop(context); // Retour à la page précédente (scencepage)
            },          child: Text('Supprimer la boîte'),
                ),
        ),],);
  }
}





