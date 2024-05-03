import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

String generateUniqueId() {
  var uuid = Uuid();
  return uuid.v4();
}

// ignore: camel_case_types
class On_off_tv extends StatefulWidget {

  final int  id;
  final String code;
  final bool isActivated;
  final String tvIcon;
   final bool malak;
 
  On_off_tv({required this.id,required this.code, required this.isActivated,required this.tvIcon,required this.malak,});

  @override
  State<On_off_tv> createState() => _On_off_tvState(isActivated: isActivated,tvIcon:tvIcon,malak:malak);
}

// ignore: camel_case_types
class _On_off_tvState extends State<On_off_tv> {
  final bool malak;
  
  late MqttServerClient mqttClient;
  late  String tvIcon ;
  late bool  isActivated;
  
  _On_off_tvState({required this.malak,required this.isActivated,required this.tvIcon}) ;

  @override
  void initState() {
    super.initState();
    if (malak) {
                  isActivated = false;
                   if (isActivated ) {
                tvIcon = 'icon/tvOn.ico';
                  } else {
          tvIcon = 'icon/tvOff.ico'; 
        }
                  _saveistvOnState(isActivated);
                   _savetvIconState(tvIcon);


        }else{
          _loadistvOnState();
          _loadtvIconState();
     }
    
    _connectToMqtt();
  }
Future<void> _loadistvOnState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isActivated = prefs.getBool(_getUniqueKey()) ?? false;
    });
  }

  Future<void> _saveistvOnState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getUniqueKey(), value);
  }

  String _getUniqueKey() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return 'isActivated_${widget.id}';
  }
  
  Future<void> _loadtvIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tvIcon = prefs.getString(_getUniqueKey2()) ?? 'icon/tvOff.ico';
    });
  }

  Future<void> _savetvIconState(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_getUniqueKey2(), value);
  }

  String _getUniqueKey2() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return 'tvIcon_${widget.id}';
  }
  /*
 

  }
*/
void _connectToMqtt() async {
    final String mqttServer = 'test.mosquitto.org';
    final int mqttPort = 1883;
    final String clientId = generateUniqueId();

    mqttClient = MqttServerClient(mqttServer, clientId);
    mqttClient.port = mqttPort;
    mqttClient.logging(on: true);

    try {
      await mqttClient.connect();
      print('Connected to MQTT broker');
    } catch (e) {
      print('Failed to connect to MQTT broker: $e');
    }
  }

  void _toggletvState(bool newState) {
    if (mqttClient.connectionStatus != null &&
        mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client is connected. Toggling lamp state...');
      setState(() {
         if (malak) {
                  isActivated = false;

        } else {
           isActivated = newState;
        }
        
        if (isActivated ) {
          tvIcon = 'icon/tvOn.ico';
          _publishMessage('ON');
           _saveistvOnState(isActivated);
         _savetvIconState(tvIcon);
        } else {
          tvIcon = 'icon/tvOff.ico';
          _publishMessage('OFF');
             _saveistvOnState(isActivated);
         _savetvIconState(tvIcon);

        }
        
         
      });
    } else {
      print('MQTT client is not connected.');
     /* setState(() {
         if (malak) {
                  isActivated = false;

        } else {
           isActivated = newState;
        }
        
        if (isActivated ) {
          tvIcon = 'icon/tvOn.ico';
        //  _publishMessage('ON');
         // updateBoxetat('ON');
          print('ON');
           _saveistvOnState(isActivated);
         _savetvIconState(tvIcon);
        } else {
          tvIcon = 'icon/tvOff.ico';
      //       _publishMessage('ON');

          //  updateBoxetat('OFF');
            print('OFF');
             _saveistvOnState(isActivated);
         _savetvIconState(tvIcon);

        }
        
         
      });*/
      
    }
  }

  void _publishMessage(String message) {
    print('Publishing message: $message');
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      try {
        mqttClient.publishMessage(
          'projet13/lampe1',
          MqttQos.atMostOnce,
          builder.payload!,
        );

        print('Message published successfully');
      } catch (e) {
        print('Failed to publish message: $e');
      }
    } else {
      print('MQTT client is not connected.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Switch(
          value: isActivated,
          onChanged: (newValue) {
            _toggletvState(newValue);
          },
          activeColor: const Color(0xFFA58BFF),
          inactiveThumbColor: const Color(0xFFFAF7FF),
          inactiveTrackColor: Colors.black.withOpacity(0.2),
        ),
                const SizedBox(width: 15),

        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 60,
            width: 60,
            child: Center(
              child: Image.asset(
                tvIcon,
                height: 50,
                width: 50,
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}
