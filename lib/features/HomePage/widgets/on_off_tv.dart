import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// ignore: camel_case_types
class On_off_tv extends StatefulWidget {
   final String code ;
   
   On_off_tv({required this.code});



  

  @override
  State<On_off_tv> createState() => _On_offState();
}

// ignore: camel_case_types
class _On_offState extends State<On_off_tv> {
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
    final String clientId = 'Hana'; // Unique client ID

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
        'projet13/device', MqttQos.atMostOnce, builder.payload!);
  }

  @override
  void dispose() {
    mqttClient.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon and button row
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
            _toggleTvState();
          },
          activeColor: const Color(0xFFA58BFF), // Active color (when switch is on)
          inactiveThumbColor: const Color(0xFFFAF7FF), // Thumb color (when switch is off)
          inactiveTrackColor:
              Colors.black.withOpacity(0.2), // Track color (when switch is off)
        ),
      ],
    );
  }
}
