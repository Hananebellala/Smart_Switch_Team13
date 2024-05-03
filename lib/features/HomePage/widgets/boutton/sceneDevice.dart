import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';
/********************************************************box  ********************************************************************* */
// ignore: camel_case_types


String generateUniqueId() {
  var uuid = Uuid();
  return uuid.v4();
}


// ignore: camel_case_types
class On_Off_Scene extends StatefulWidget {
  final String code;
  On_Off_Scene({required this.code});


  @override
  State<On_Off_Scene> createState() => _On_offState();
}


// ignore: camel_case_types
class _On_offState extends State<On_Off_Scene> {
  late bool _isOn;
  late MqttServerClient mqttClient;


  @override
  void initState() {
    super.initState();
    _isOn = false; // Initial state is 'off'
    _connectToMqtt();
   
  }


  void _connectToMqtt() async {
    // ignore: prefer_const_declarations
    final String mqttServer = 'test.mosquitto.org'; // MQTT broker address
    // ignore: prefer_const_declarations
    final int mqttPort = 1883; // MQTT broker port
    // ignore: prefer_const_declarations
    final String clientId = generateUniqueId(); // Unique client ID


    mqttClient = MqttServerClient(mqttServer, clientId);
    mqttClient.port = mqttPort; // Set MQTT broker port


    final MqttConnectMessage connectMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .keepAliveFor(60); // Keep alive interval in seconds


    try {
      await mqttClient.connect();
      print('Connected to MQTT broker');
    } catch (e) {
      print('Failed to connect to MQTT broker: $e');
    }
  }


  void _toggleTvState() {
    if (mqttClient.connectionStatus?.state == MqttConnectionState.connected) {
      setState(() {
        _isOn = !_isOn;
        _publishMessage(_isOn ? 'ON' : 'OFF'); // Publish message to MQTT topic
      });
    } else {
      print('MQTT client is not connected.');
    }
  }


  void _publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    mqttClient.publishMessage(
        'projet13/scene', MqttQos.atMostOnce, builder.payload!);
  }


  @override
  void dispose() {
    mqttClient.disconnect();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        
        Row(
          children: [
            // Icon and button row
            const SizedBox(width: 15),
           
            const SizedBox(width: 15),
            Switch(
              value: _isOn,
              onChanged: (newValue) {
                _toggleTvState();
              },
              activeColor:
                  const Color(0xFFA58BFF), // Active color (when switch is on)
              inactiveThumbColor:
                  const Color(0xFFFAF7FF), // Thumb color (when switch is off)
              inactiveTrackColor:
                  Colors.black.withOpacity(0.2), // Track color (when switch is off)
            ),
            
          ],
        ),
                const SizedBox(width: 15),
                const SizedBox(height: 15),

      ],
    );
  }
}








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
  late bool _isChecked;


  @override
  /*void initState() {
    super.initState();
    _isOn =
        widget.isChecked; // Initialize _isOn with the provided isChecked value
    _isChecked = false; // Initial state for the check circle is unchecked
  }*/
void initState() {
    super.initState();
    _loadCheckedState();
    
  _loadisOnState();
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
 /* void initState() {
    super.initState();
    _loadCheckedState();
  }*/

  Future<void> _loadisOnState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOn = prefs.getBool(_getUniqueKey2()) ?? false;
    });
  }

  Future<void> _saveisOnState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getUniqueKey2(), value);
  }

  String _getUniqueKey2() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return 'isOn_${widget.deviceName}';
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
            child: On_Off_Scene(
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
    );
  }
}






