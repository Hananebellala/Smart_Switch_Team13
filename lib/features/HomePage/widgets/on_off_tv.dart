import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

String generateUniqueId() {
  var uuid = Uuid();
  return uuid.v4();
}

// ignore: camel_case_types
class On_off_tv extends StatefulWidget {
  final String code;
  final bool isActivated;
  On_off_tv({required this.code, required this.isActivated});

  @override
  State<On_off_tv> createState() => _On_offState(isActivated: isActivated);
}

// ignore: camel_case_types
class _On_offState extends State<On_off_tv> {
  late bool _isOn;
  late MqttServerClient mqttClient;

  var isActivated;

  _On_offState({required this.isActivated}) : _isOn = false;

  @override
  void initState() {
    super.initState();
    _connectToMqtt();
  }

  void _connectToMqtt() async {
    final String mqttServer = 'test.mosquitto.org';
    final int mqttPort = 1883;
    final String clientId = generateUniqueId();

    mqttClient = MqttServerClient(mqttServer, clientId);
    mqttClient.port = mqttPort;

    final MqttConnectMessage connectMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .keepAliveFor(60);

    try {
      await mqttClient.connect();
      print('Connected to MQTT broker');

      // Subscribe to the topic 'projet13/scene'
      mqttClient.subscribe('projet13/scene', MqttQos.atMostOnce);
      mqttClient.subscribe('projet13/device1', MqttQos.atMostOnce);
      mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
        final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
        final String pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        
        final String pt1 =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        // Check the received message and update the state accordingly

        if(pt1=='ON'){
          _isOn = true;
        }else if(pt1=='OFF'){
          _isOn = true;
        }
        if (pt == 'ON' && isActivated) {
          setState(() {
            _isOn = true;
            print('_isOn changed to true');
            // Publish 'ON' to the topic 'projet13/device'
            _publishMessage('ON');
          });
        } else if (pt == 'OFF' && isActivated) {
          setState(() {
            _isOn = false;
            print('_isOn changed to false');
            // Publish 'OFF' to the topic 'projet13/device'
            _publishMessage('OFF');
          });
        }
      });
    } catch (e) {
      print('Failed to connect to MQTT broker: $e');
    }
  }

  void _toggleTvState() {
    if (mqttClient.connectionStatus?.state == MqttConnectionState.connected) {
      setState(() {
        _isOn = !_isOn;
        _publishMessage(_isOn ? 'ON' : 'OFF');
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
          activeColor: const Color(0xFFA58BFF),
          inactiveThumbColor: const Color(0xFFFAF7FF),
          inactiveTrackColor: Colors.black.withOpacity(0.2),
        ),
      ],
    );
  }
}
