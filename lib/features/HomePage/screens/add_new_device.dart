import 'package:flutter/material.dart';



import 'package:uuid/uuid.dart';


class CancelBox extends StatefulWidget {
  final Function() onDelete;
  CancelBox({required this.onDelete});
  @override
  _CancelBoxState createState() => _CancelBoxState();
}

class _CancelBoxState extends State<CancelBox> {
  bool _isSwitchOn = false; // Track the state of the switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFA),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(17, 120, 0, 145),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Smart TV',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      height: 1.4,
                      letterSpacing: 0.4,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: OnOffTv(
                  isActivated: _isSwitchOn,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitchOn = value;
                    });
                  },
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 80, 0, 20),
                  child: SizedBox(
                    width: 300,
                    height: 241.9,
                    child: _isSwitchOn
                        ? Image.asset('images/tv2.png')
                        : Image.asset('images/tv (1).png'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 100, 30, 400),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 239,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _deleteBox(); // Retour à la page précédente (scencepage)
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFA58BFF),
                            ), // Set button background color
                            elevation: MaterialStateProperty.all<double>(
                                0), // Set elevation to 0
                            shadowColor: MaterialStateProperty.all<Color>(
                              Colors.transparent,
                            ), // Set shadow color to transparent
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ), // Set button border radius
                          ),
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(16.8, 10.5, 16.8, 10.5),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                height: 1,
                                letterSpacing: 0.1,
                                color: const Color(0xFFFFFAFA),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Perform save logic here
                            Navigator.of(context)
                                .pop(); // Navigate back to the previous screen
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF6900FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  height: 1,
                                  letterSpacing: 0.1,
                                  color: const Color(0xFFFFFAFA),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete this device?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                // Perform deletion logic here
                widget.onDelete(); // Appel de la fonction onDelete
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
          ],
        );
      },
    );
  }
}

class OnOffTv extends StatefulWidget {
  final bool isActivated;
  final Function(bool) onChanged;
  OnOffTv({required this.isActivated, required this.onChanged});

  @override
  State<OnOffTv> createState() => _OnOffTvState();
}

class _OnOffTvState extends State<OnOffTv> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      child: GestureDetector(
        onTap: () {
          widget.onChanged(!widget.isActivated);
        },
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Switch(
            value: widget.isActivated,
            onChanged: widget.onChanged,
            activeColor: const Color(0xFFA58BFF),
            inactiveThumbColor: const Color(0xFFFAF7FF),
            inactiveTrackColor: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}

String generateUniqueId() {
  var uuid = Uuid();
  return uuid.v4();
}

class On_Off_Scene extends StatefulWidget {
  final String code;
  final bool isActivated;
  final Function(bool) onChanged; // Callback function

  On_Off_Scene(
      {required this.code, required this.isActivated, required this.onChanged});

  @override
  State<On_Off_Scene> createState() => _On_Off_SceneState();
}

class _On_Off_SceneState extends State<On_Off_Scene> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.isActivated;
  }

  void _toggleState() {
    setState(() {
      _isOn = !_isOn;
    });
    widget.onChanged(_isOn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5, // Adjust the scale factor as needed
          child: Switch(
            value: _isOn,
            onChanged: (newValue) {
              _toggleState();
            },
            activeColor: const Color(0xFFA58BFF),
            inactiveThumbColor: const Color(0xFFFAF7FF),
            inactiveTrackColor: Colors.black.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}

class CancelBox1 extends StatefulWidget {
  final Function() onDelete;
  CancelBox1({required this.onDelete});
  @override
  _CancelBox1State createState() => _CancelBox1State();
}

class _CancelBox1State extends State<CancelBox1> {
  bool _isSwitchOn = false; // Track the state of the switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFA),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(17, 120, 0, 145),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Smart Light',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      height: 1.4,
                      letterSpacing: 0.4,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: OnOffTv(
                  isActivated: _isSwitchOn,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitchOn = value;
                    });
                  },
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 80, 0, 20),
                  child: SizedBox(
                    width: 300,
                    height: 241.9,
                    child: _isSwitchOn
                        ? Image.asset('images/light.png')
                        : Image.asset('images/lighon.png'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 100, 30, 400),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 239,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _deleteBox(); // Retour à la page précédente (scencepage)
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFA58BFF),
                            ), // Set button background color
                            elevation: MaterialStateProperty.all<double>(
                                0), // Set elevation to 0
                            shadowColor: MaterialStateProperty.all<Color>(
                              Colors.transparent,
                            ), // Set shadow color to transparent
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ), // Set button border radius
                          ),
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(16.8, 10.5, 16.8, 10.5),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                height: 1,
                                letterSpacing: 0.1,
                                color: const Color(0xFFFFFAFA),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Perform save logic here
                            Navigator.of(context)
                                .pop(); // Navigate back to the previous screen
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF6900FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  height: 1,
                                  letterSpacing: 0.1,
                                  color: const Color(0xFFFFFAFA),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete this device?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                // Perform deletion logic here
                widget.onDelete(); // Appel de la fonction onDelete
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
          ],
        );
      },
    );
  }
}
