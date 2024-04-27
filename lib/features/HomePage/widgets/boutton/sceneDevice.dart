import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/HomePage/widgets/on_off_tv.dart';

/********************************************************box  ********************************************************************* */
// ignore: camel_case_types

class SceneDevice extends StatefulWidget {
  final String deviceName;
  final bool isChecked;

  const SceneDevice({
    Key? key,
    required this.deviceName,
    required this.isChecked,
  }) : super(key: key);

  @override
  _SceneDeviceState createState() => _SceneDeviceState();
}

class _SceneDeviceState extends State<SceneDevice> {
  late bool _isOn;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isOn =
        widget.isChecked; // Initialize _isOn with the provided isChecked value
    _isChecked = false; // Initial state for the check circle is unchecked
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7FF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 10,
            child: Text(
              widget.deviceName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          // On/Off switch
          Positioned(
            bottom: 0,
            right: 113,
            child: On_off_tv(
              code: widget.deviceName,
            ),
          ),
          // Check circle
          Positioned(
            bottom: 15,
            right: 15,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isChecked = !_isChecked;
                });
              },
              child: Container(
                width: 32, // Adjust size as needed
                height: 32, // Adjust size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _isChecked ? const Color(0xFFA58BFF) : Colors.transparent,
                  border: Border.all(
                    color: _isChecked ? Colors.transparent : Colors.black,
                    width: 2,
                  ),
                ),
                child: _isChecked
                    ? Center(
                        child: Text(
                          '\u2713', // Unicode character for checkmark
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
