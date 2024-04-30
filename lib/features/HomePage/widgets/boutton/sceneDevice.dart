import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/HomePage/widgets/on_off_tv.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late bool _isChecked ;

  
  @override
  void initState() {
    super.initState();
    _loadCheckedState();
    _loadOnState();
  }

  Future<void> _loadCheckedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = prefs.getBool(_getUniqueKey()) ?? false;
    });
  }

  Future<void> _saveCheckedState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getUniqueKey(), value);
  }

  String _getUniqueKey() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return 'isChecked_${widget.deviceName}';
  }
Future<void> _loadOnState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOn = prefs.getBool(_getUniqueKey2()) ?? false;
    });
  }

  Future<void> _saveOnState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getUniqueKey2(), value);
  }

  String _getUniqueKey2() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return 'isOn_${widget.deviceName}';
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
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
                right: 10,
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
                child:Switch(
                  value: _isOn,
                  onChanged: (newValue) {
                    setState(() {
                      _isOn = newValue;
                    });
                    _saveOnState(newValue);
                  },
                  activeColor: const Color(0xFFA58BFF),
                  inactiveThumbColor: const Color(0xFFFAF7FF),
                  inactiveTrackColor: Colors.black.withOpacity(0.2),
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
                   _saveCheckedState(_isChecked);

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
        ),
        SizedBox(
            height: 25,
          ),
      ],
    );
  }
}
