// ignore_for_file: camel_case_types, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


class on_off_lampe extends StatefulWidget {
  final int id;
  final String code;
  final bool isLampOn;
  final String lampIcon;
  final bool malak;

  const on_off_lampe(
      {required this.id,
      required this.code,
      required this.isLampOn,
      required this.lampIcon,
      required this.malak});

  @override
  State<on_off_lampe> createState() =>
      _on_off_lampeState(isLampOn: isLampOn, lampIcon: lampIcon, malak: malak);
}

class _on_off_lampeState extends State<on_off_lampe> {
  late String lampIcon;
  late bool isLampOn;
  final bool malak;

  late MqttServerClient mqttClient;

  _on_off_lampeState(
      {required this.isLampOn, required this.lampIcon, required this.malak});

  @override
  void initState() {
    super.initState();
    if (malak) {
      isLampOn = false;
      lampIcon = 'icon/lampe.ico';
      _saveisLampOnState(isLampOn);
      _saveLampIconState(lampIcon);
    } else {
      _loadLampIconState();
      _loadisLampOnState();
      _loadLampIconState();
    }

    _connectToMqtt(widget.code);
  }

  Future<void> _loadisLampOnState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLampOn = prefs.getBool(_getUniqueKey()) ?? false;
    });
  }

  Future<void> _saveisLampOnState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getUniqueKey(), value);
  }

  String _getUniqueKey() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return 'isLampOn_${widget.id}';
  }

  Future<void> _loadLampIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lampIcon = prefs.getString(_getUniqueKey2()) ?? 'icon/lampe.ico';
    });
  }

  Future<void> _saveLampIconState(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_getUniqueKey2(), value);
  }

  String _getUniqueKey2() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return 'lampIcon_${widget.id}';
  }

  void _connectToMqtt(String code) async {
    final String mqttServer = 'test.mosquitto.org';
    final int mqttPort = 1883;
    final String clientId = code;

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

  void _toggleLampState(bool newState, String code) {
    if (mqttClient.connectionStatus != null &&
        mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client is connected. Toggling lamp state...');
      setState(() {
        if (malak) {
          isLampOn = false;
        } else {
          isLampOn = newState;
        }

        if (isLampOn) {
          lampIcon = 'icon/lampeOn.ico';
          _publishMessage('ON', code);
        } else {
          lampIcon = 'icon/lampe.ico';
          _publishMessage('OFF', code);
        }
        _saveisLampOnState(isLampOn);
        _saveLampIconState(lampIcon);
      });
    } else {
      print('MQTT client is not connected.');
    }
  }

  void _publishMessage(String message, String code) {
    print('Publishing message: $message');
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      try {
        mqttClient.publishMessage(
          code,
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
          value: isLampOn,
          onChanged: (newValue) {
            _toggleLampState(newValue, widget.code);
          },
          activeColor: const Color(0xFFA58BFF),
          inactiveThumbColor: const Color(0xFFFAF7FF),
          inactiveTrackColor: Colors.black.withOpacity(0.2),
        ),
        const SizedBox(width: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            lampIcon,
            height: 65,
            width: 65,
          ),
        ),
      ],
    );
  }
}


