import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/HomePage/widgets/on_off_tv.dart';
import 'package:shared_preferences/shared_preferences.dart';

/********************************************************box  ********************************************************************* */
// ignore: camel_case_types
/*
class SceneBox extends StatefulWidget {
  final String deviceName;
  //final bool isChecked;

  const SceneBox({
    Key? key,
    required this.deviceName,
   // required this.isChecked,
  }) : super(key: key);

  @override
  _SceneBoxState createState() => _SceneBoxState();
}

class _SceneBoxState extends State<SceneBox> {
  late  bool _isChecked ;

  @override
  
void initState() {
    super.initState();
    _loadCheckedState();
  }

  // Charger l'état de _isChecked depuis les préférences partagées
  Future<void> _loadCheckedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Récupérer la valeur de _isChecked ou utiliser false comme valeur par défaut
      _isChecked = prefs.getBool('isChecked') ?? false;
    });
  }

  // Sauvegarder l'état de _isChecked dans les préférences partagées
  Future<void> _saveCheckedState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isChecked', value);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
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
          child: Row(
            children: [
              SizedBox(width: 10,),
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
               right:0,
                child: Switch(
                          value: _isChecked,
                          onChanged: (newValue) {
                             setState(() {
                             _isChecked = !_isChecked;
                                  });
                                    _saveCheckedState(_isChecked);
                          },
                          activeColor: const Color(0xFFA58BFF),
                          inactiveThumbColor: const Color(0xFFFAF7FF),
                          inactiveTrackColor: Colors.black.withOpacity(0.2),
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
*/
class SceneBox extends StatefulWidget {
  final String deviceName;

  const SceneBox({
    Key? key,
    required this.deviceName,
  }) : super(key: key);

  @override
  _SceneBoxState createState() => _SceneBoxState();
}

class _SceneBoxState extends State<SceneBox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _loadCheckedState();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
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
          child: Row(
            children: [
              SizedBox(width: 10,),
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
              Positioned(
                right:0,
                child: Switch(
                  value: _isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      _isChecked = newValue;
                    });
                    _saveCheckedState(newValue);
                  },
                  activeColor: const Color(0xFFA58BFF),
                  inactiveThumbColor: const Color(0xFFFAF7FF),
                  inactiveTrackColor: Colors.black.withOpacity(0.2),
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