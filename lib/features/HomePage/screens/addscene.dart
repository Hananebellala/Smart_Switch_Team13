import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../widgets/elements/info_box.dart';

import '../../HomePage/widgets/boutton/controle_Boutton.dart';
import '../../HomePage/widgets/boutton/home_boutton.dart';
import '../../HomePage/widgets/boutton/paramettre_boutton.dart';
import '../../HomePage/widgets/boutton/scence_boutton.dart';
import '../widgets/goBack.dart';
import '../../HomePage/widgets/boutton/sceneDevice.dart';
import 'scencepage.dart';

class Addscene extends StatefulWidget {
  const Addscene({Key? key}) : super(key: key);

  @override
  _AddsceneState createState() => _AddsceneState();
}

class _AddsceneState extends State {
  String scene_name = '';
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  late MqttServerClient mqttClient;

  @override
  void initState() {
    super.initState();
    initializeSpeechRecognition();
    _connectToMqtt();
  }

  void _connectToMqtt() async {
    final String mqttServer = 'test.mosquitto.org'; // MQTT broker address
    final int mqttPort = 1883; // MQTT broker port
    final String clientId = 'Hanine'; // Unique client ID

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

  @override
  void dispose() {
    mqttClient.disconnect();
    super.dispose();
  }

  String updateInputValue(String newValue) {
    return newValue;
  }

  Future<void> initializeSpeechRecognition() async {
    bool isPermissionGranted = await getMicrophonePermission();
    await handlePermissionResponse(isPermissionGranted);
  }

  Future<bool> getMicrophonePermission() async {
    bool hasPermission = await _speech.initialize(
      onError: (error) =>
          print('Error initializing speech recognition: $error'),
    );

    if (!hasPermission) {
      print('Microphone permission not granted');
    }

    return hasPermission;
  }

  Future<void> handlePermissionResponse(bool isPermissionGranted) async {
    if (!isPermissionGranted) {
// Handle permission not granted
    }
  }

  bool isSpeechRecognitionAvailable() {
    return _speech.isAvailable;
  }

  void startSpeechRecognition() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _text = result.recognizedWords;
          _publishMessage(_text); // Publish the recognized text to MQTT
        });
      },
      listenFor: Duration(minutes: 1),
      cancelOnError: true,
    );
  }

  void stopSpeechRecognition() {
    _speech.stop();
  }

  void _publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    mqttClient.publishMessage(
        'VoiceCommTea13', MqttQos.atMostOnce, builder.payload!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 57), // Space from top
              Row(
                children: [
                  GoBack(previousScreen: scencepage()), // GoBack widget
                  SizedBox(
                      width:
                          60), // Space between "Go Back" and "Account Settings"
                  Text(
                    'Add Scene',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600, // SemiBold
                      fontSize: 24.0, // Adjust the font size as needed
                      color: Colors.black, // Black color
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Create your scene!',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            color: Colors.black)),
                    SizedBox(height: 20),
                    Text(
                        'Customize devices in your bedroom to set a certain mood',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                            color: Colors.black)),
                    SizedBox(height: 40),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: const Text('Scene Name'),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                      child: InfoBox(
                        initialValue: '',
                        onChanged: (newValue) {
                          scene_name = updateInputValue(newValue);
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    SceneDevice(deviceName: 'Hanane', isChecked: false)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF6900FF),
            shape: const CircleBorder(),
            onPressed: () {
              if (isSpeechRecognitionAvailable()) {
                _isListening
                    ? stopSpeechRecognition()
                    : startSpeechRecognition();
                setState(() {
                  _isListening = !_isListening;
                });
              } else {
// Speech recognition not available, show error message or alternative
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Image.asset(
                'icon/Microphone.ico',
                height: 50,
                width: 70,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Home_boutton(pathIcon: 'icon/home.ico'),
              SizedBox(width: 30),
              Controle_boutton(pathIcon: 'icon/controle.ico'),
              SizedBox(width: 90),
              Scence_boutton(pathIcon: 'icon/sCENCE_1.ico'),
              SizedBox(width: 30),
              Paramettre_boutton(pathIcon: 'icon/Setting.ico'),
            ],
          ),
        ),
      ),
    );
  }
}
