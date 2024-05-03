import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:uuid/uuid.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Colors.teal,
          ledColor: Colors.tealAccent,
        ),
      ],
    );
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> showNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }
}

String generateUniqueId() {
  var uuid = Uuid();
  return uuid.v4();
}

class NotificationRectangle extends StatefulWidget {
  @override
  _NotificationRectangleState createState() => _NotificationRectangleState();
}

class _NotificationRectangleState extends State<NotificationRectangle> {
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
    final String topic = 'projet13/notif';

    mqttClient = MqttServerClient(mqttServer, clientId);
    mqttClient.port = mqttPort;

    final MqttConnectMessage connectMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .keepAliveFor(60);

    try {
      await mqttClient.connect();
      print('Connected to MQTT broker');

      mqttClient.subscribe(topic, MqttQos.atMostOnce);
      print('Subscribed to MQTT topic: $topic');

      mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
        final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
        final String message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('Received MQTT message: $message');

        // Show notification when a message is received
        NotificationService.showNotification('New Notification', message);
      });

      // Check MQTT client connection status
      mqttClient.onConnected = () {
        print('MQTT client connected');
      };

      mqttClient.onSubscribed = (topic) {
        print('MQTT client subscribed to topic: $topic');
      };

      mqttClient.onUnsubscribed = (topic) {
        print('MQTT client unsubscribed from topic: $topic');
      };
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
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600, // SemiBold
                    fontSize: 24.0, // Adjust the font size as needed
                    color: Colors.black, // Black color
                  ),
                ),
                SizedBox(height: 200), // Space between title and image
                NotificationRectangle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
