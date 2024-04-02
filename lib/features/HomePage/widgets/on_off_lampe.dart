import 'package:flutter/material.dart';

//*********************** on-off-Icon*****************
class on_off_lampe extends StatefulWidget {
  const on_off_lampe({Key? key});

  @override
  State<on_off_lampe> createState() => _On_offState();
}

class _On_offState extends State<on_off_lampe> {
  String _lampe = 'icon/lampe.ico';
  bool on = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon and button row
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            _lampe,
            height: 65,
            width: 65,
          ),
        ),
        const SizedBox(width: 15),
        const SizedBox(width: 15),

        Switch(
          value: on,
          onChanged: (newValue) {
            setState(() {
              on = newValue;
              if (on) {
                _lampe = 'icon/lampeOn.ico';
              } else {
                _lampe = 'icon/lampe.ico';
              }
            });
          },
          activeColor: const Color(0xFFA58BFF), // Active color (when switch is on)
          inactiveThumbColor: Color(0xFFFAF7FF), // Thumb color (when switch is off)
          inactiveTrackColor: Colors.black.withOpacity(0.2), // Track color (when switch is off)
        ),
      ],
    );
  }
}

