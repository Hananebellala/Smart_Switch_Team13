import 'package:flutter/material.dart';
import '../widgets/goBack.dart';
import 'package:smart_switch_team13/features/HomePage/screens/homepage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

String generateUniqueId() {
  var uuid = Uuid();
  return uuid.v4();
}

class NotificationRectangle extends StatefulWidget {
  @override
  _NotificationRectangleState createState() => _NotificationRectangleState();
}

class _NotificationRectangleState extends State {
  String _notificationText = '';

  late MqttServerClient mqttClient;

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

      mqttClient.subscribe('projet13/notif', MqttQos.atMostOnce);
      mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
        final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
        final String pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        setState(() {
          _notificationText = pt;
        });
      });
    } catch (e) {
      print('Failed to connect to MQTT broker: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFBF0C9),
      child: Center(
        child: Text(
          _notificationText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    mqttClient.disconnect();
    super.dispose();
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _notificationText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(27, 20, 27, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 57), // Space from top
                const Row(
                  children: [
                    GoBack(previousScreen: Home()), // GoBack widget
                    SizedBox(
                      width: 40,
                    ), // Space between "Go Back" and "Account Settings"
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600, // SemiBold
                        fontSize: 24.0, // Adjust the font size as needed
                        color: Colors.black, // Black color
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200), // Space between title and image
                if (_notificationText.isEmpty)
                  Image.asset(
                    'images/Reminders-bro.png',
                    fit: BoxFit.cover,
                  )
                else
                  NotificationRectangle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
