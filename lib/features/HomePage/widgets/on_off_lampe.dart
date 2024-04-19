import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// ignore: camel_case_types
class on_off_lampe extends StatefulWidget {
  const on_off_lampe({super.key});

  @override
  State<on_off_lampe> createState() => _on_off_lampeState();
}

// ignore: camel_case_types
class _on_off_lampeState extends State<on_off_lampe> {
  late String _lampIcon;
  late bool isLampOn;
  late MqttServerClient mqttClient;

  @override
  void initState() {
    super.initState();
    _lampIcon = 'icon/lampe.ico'; // Initial state is 'off'
    isLampOn = false; // Initial state is 'off'
    _connectToMqtt();
  }

  void _connectToMqtt() async {
  // ignore: prefer_const_declarations
  final String mqttServer = 'test.mosquitto.org'; // MQTT broker address
  // ignore: prefer_const_declarations
  final int mqttPort = 1883; // MQTT broker port
  // ignore: prefer_const_declarations
  final String clientId = 'Hanane'; // Unique client ID

  mqttClient = MqttServerClient(mqttServer, clientId);
  mqttClient.port = mqttPort; // Set MQTT broker port

  // ignore: unused_local_variable
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


  void _toggleLampState() {
    if (1==1) {
      setState(() {
        isLampOn = !isLampOn;
        if (isLampOn) {
          _lampIcon = 'icon/lampeOn.ico';
          _publishMessage('ON'); // Publish 'ON' message to MQTT topic
        } else {
          _lampIcon = 'icon/lampe.ico';
          _publishMessage('OFF'); // Publish 'OFF' message to MQTT topic
        }
      });
    } else {
      print('MQTT client is not connected.');
    }
  }

  void _publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    mqttClient.publishMessage(
        'projet13/lampe1', MqttQos.atMostOnce, builder.payload!);
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