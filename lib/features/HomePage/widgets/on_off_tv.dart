import 'package:flutter/material.dart';

class On_off_tv extends StatefulWidget {
  const On_off_tv({Key? key});

  @override
  State<On_off_tv> createState() => _On_offState();
}

class _On_offState extends State<On_off_tv> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 60,
            width: 60,
            
            child: Center(
              child: Image.asset(
                'icon/${_isOn ? 'tvOn' : 'tvOff'}.ico',
                height: 40,
                width: 40,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Switch(
          value: _isOn,
          onChanged: (newValue) {
            setState(() {
              _isOn = newValue;
            });
          },
          activeColor: const Color(0xFFA58BFF), // Active color (when switch is on)
          inactiveThumbColor: const Color(0xFFFAF7FF), // Thumb color (when switch is off)
          inactiveTrackColor: Colors.black.withOpacity(0.2), // Track color (when switch is off)
        ),
      ],
    );
  }
}
