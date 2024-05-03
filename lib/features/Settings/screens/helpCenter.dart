import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../HomePage/widgets/boutton/controle_Boutton.dart';
import '../../HomePage/widgets/boutton/home_boutton.dart';
import '../../HomePage/widgets/boutton/paramettre_boutton.dart';
import '../../HomePage/widgets/boutton/scence_boutton.dart';
import 'settings_page.dart';
import '../widgets/goBack.dart';
import '../widgets/rectangle7.dart';
import '../widgets/rectangle8.dart';
import '../widgets/rectangle5.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
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
    final String clientId = 'Hannnoone'; // Unique client ID

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
      // Display an error message to the user, e.g., using a Snackbar
    }
  }

  @override
  void dispose() {
    mqttClient.disconnect();
    super.dispose();
  }

  void initializeSpeechRecognition() async {
    print('Initializing speech recognition...');
    bool isPermissionGranted = await getMicrophonePermission();
    if (!isPermissionGranted) {
      print('Microphone permission not granted');
      // Handle permission not granted
      return;
    }

    try {
      bool available = await _speech.initialize(
        onError: (error) {
          print('Error initializing speech recognition: $error');
          // Handle initialization error
        },
      );
      if (available) {
        print('Speech recognition initialized');
      } else {
        print('Speech recognition not available');
        // Handle unavailability
      }
    } catch (error) {
      print('Error initializing speech recognition: $error');
      // Handle initialization error
    }
  }

  Future<bool> getMicrophonePermission() async {
    print('Getting microphone permission...');
    bool hasPermission = await _speech.initialize(
      onError: (error) =>
          print('Error initializing speech recognition: $error'),
    );

    if (!hasPermission) {
      print('Microphone permission not granted');
    }

    return hasPermission;
  }

  bool isSpeechRecognitionAvailable() {
    try {
      return _speech.isAvailable;
    } catch (error) {
      // Handle the error here (same as above)
      print('Error checking speech recognition availability: $error');
      return false;
    }
  }

  void startSpeechRecognition() {
    print('Starting speech recognition...');
    _speech.listen(
      onResult: (result) {
        setState(() {
          _text = result.recognizedWords;
          print('Recognized text: $_text');
          _publishMessage(_text);
        });
      },
      listenFor: Duration(minutes: 1),
      cancelOnError: true,
    );
  }

  void stopSpeechRecognition() {
    print('Stopping speech recognition...');
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
    // Get the device screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define the size of the image
    const imageSize = Size(183, 186.54);

    // Calculate the position of the image
    final imageX = (screenWidth - imageSize.width) / 2;

    // Define the percentage of the screen height for the image position
    const imageYPercentage = 0.03; // Adjust as needed

    // Calculate the position of the image
    final imageY = screenHeight * imageYPercentage;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 57), // Space from top
              Row(
                children: [
                  GoBack(previousScreen: SettingsPage()), // GoBack widget
                  SizedBox(
                      width:
                          40), // Space between "Go Back" and "Account Settings"
                  Text(
                    'Help Center',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600, // SemiBold
                      fontSize: 24.0, // Adjust the font size as needed
                      color: Colors.black, // Black color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80), // Additional space
              const Rectangle5(),

              const SizedBox(height: 31), // Additional space
              const Rectangle7(),
              const SizedBox(height: 31), // Additional space
              const Rectangle8(),
              SizedBox(height: imageY), // Space to position the image
              Column(
                children: [
                  SizedBox(
                    width: imageSize.width,
                    height: imageSize.height,
                    child: Image.asset(
                      'images/Questions_bro.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                      height: 0), // Add space between the image and the button
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
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
        shape:
            CircularNotchedRectangle(), // quelle a fait border -aspace au dessous de bottom
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
