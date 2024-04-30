import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';
/*
// ignore: camel_case_types
class on_off_lampe extends StatefulWidget {
  final String code;
  
  const on_off_lampe({required this.code,});

  @override
  State<on_off_lampe> createState() => _on_off_lampeState();
}

// ignore: camel_case_types
class _on_off_lampeState extends State<on_off_lampe> {
  late String _lampIcon;

  late bool isLampOn=true;
  late MqttServerClient mqttClient;

  @override
  void initState() {
    super.initState();
    if ( isLampOn ==false){ _lampIcon = 'icon/lampe.ico'; // Initial state is 'off'
    isLampOn = false;}else{ _lampIcon = 'icon/lampeOn.ico'; // Initial state is 'off'
    isLampOn = true;}
    // Initial state is 'off'
    _connectToMqtt();
  }

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

  void _toggleLampState() {
    if (mqttClient.connectionStatus != null &&
        mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client is connected. Toggling lamp state...');
      setState(() {
        isLampOn = !isLampOn;
        if (isLampOn) {
          _lampIcon = 'icon/lampeOn.ico';
          _publishMessage('ON');
        } else {
          _lampIcon = 'icon/lampe.ico';
          _publishMessage('OFF');
        }
      });
    } else {
      print('MQTT client is not connected.');
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
        // Failed to publish message
        print('Failed to publish message: $e');
      }
    } else {
      print('MQTT client is not connected.');
    }
  }

  @override
 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon and button row
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            _lampIcon,
            height: 65,
            width: 65,
          ),
        ),
        const SizedBox(width: 15),
        Switch(
          value: isLampOn,
          onChanged: (newValue) {
            _toggleLampState();
            
          },
          activeColor: const Color(0xFFA58BFF),
          inactiveThumbColor: const Color(0xFFFAF7FF),
          inactiveTrackColor: Colors.black.withOpacity(0.2),
        ),
      ],
    );
  }
}

String generateUniqueId() {
  var uuid = const Uuid();
  print('uuid hereeee');
  print(uuid);
  return uuid.v4();
}*/import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

class on_off_lampe extends StatefulWidget {
  final String code;
  final bool isLampOn;

  const on_off_lampe({required this.code,required this.isLampOn});

  @override
  State<on_off_lampe> createState() => _on_off_lampeState(isLampOn: isLampOn);
}

class _on_off_lampeState extends State<on_off_lampe> {
  late String _lampIcon;
  late bool isLampOn;
  late MqttServerClient mqttClient;

  _on_off_lampeState({required this.isLampOn});

  @override
  void initState() {
    super.initState();
    _lampIcon = isLampOn ? 'icon/lampeOn.ico' : 'icon/lampe.ico';
    _connectToMqtt();
  }

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

  void _toggleLampState(bool newState) {
    if (mqttClient.connectionStatus != null &&
        mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client is connected. Toggling lamp state...');
      setState(() {
        isLampOn = newState;
        if (isLampOn) {
          _lampIcon = 'icon/lampeOn.ico';
          _publishMessage('ON');
        } else {
          _lampIcon = 'icon/lampe.ico';
          _publishMessage('OFF');
        }
      });
    } else {
      print('MQTT client is not connected.');
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
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            _lampIcon,
            height: 65,
            width: 65,
          ),
        ),
        const SizedBox(width: 15),
        Switch(
          value: isLampOn,
          onChanged: (newValue) {
            _toggleLampState(newValue);
          },
          activeColor: const Color(0xFFA58BFF),
          inactiveThumbColor: const Color(0xFFFAF7FF),
          inactiveTrackColor: Colors.black.withOpacity(0.2),
        ),
      ],
    );
  }
}

String generateUniqueId() {
  var uuid = const Uuid();
  print('uuid hereeee');
  print(uuid);
  return uuid.v4();
}
