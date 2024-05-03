import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../widgets/rectangle.dart';
import '../widgets/rectangle3.dart';
import '../widgets/rectangle4.dart';

import '../../HomePage/widgets/boutton/controle_Boutton.dart';
import '../../HomePage/widgets/boutton/home_boutton.dart';
import '../../HomePage/widgets/boutton/paramettre_boutton.dart';
import '../../HomePage/widgets/boutton/scence_boutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_switch_team13/features/authentification/index.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    final String clientId = 'Hannnine'; // Unique client ID

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
      // Request permission or display a message to the user indicating microphone access is required
      return;
    }

    try {
      await _speech.initialize(
        onError: (error) {
          print('Error initializing speech recognition: $error');
          // Handle the error here, such as displaying a message to the user
        },
      );
      print('Speech recognition initialized');
    } catch (error) {
      print('Speech recognition not available: $error');
      // Display an error message to the user indicating speech recognition is not available
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

  Future<void> handlePermissionResponse(bool isPermissionGranted) async {
    if (!isPermissionGranted) {
      // Handle permission not granted
    }
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
          _publishMessage(_text); // Publish the recognized text to MQTT
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
    final screenHeight = MediaQuery.of(context).size.height;

    // Define the size of the image
    const imageSize = Size(183, 186.54);

    // Define the percentage of the screen height for the image position
    const imageYPercentage = 0.05; // Adjust as needed

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
              const Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600, // SemiBold
                  fontSize: 24.0, // Adjust the font size as needed
                  color: Colors.black, // Black color
                ),
              ),
              const SizedBox(height: 27), // Additional space
              const Rectangle(),
              const SizedBox(height: 31), // Additional space
              const Rectangle3(),
              const SizedBox(height: 31), // Additional space
              const Rectangle4(),
              SizedBox(height: imageY), // Space to position the image
              Column(
                children: [
                  SizedBox(
                    width: imageSize.width,
                    height: imageSize.height,
                    child: SvgPicture.asset(
                      'images/Preferences-bro 1.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                      height: 0), // Add space between the image and the button
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        // Redirect the user to the login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      } catch (e) {
                        print('Error logging out: $e');
                        // Handle any errors that occur during logout
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF6900FF), // Button background color
                      minimumSize: const Size(139, 39), // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Button border radius
                        side: BorderSide(
                            color: Colors.white, width: 2), // Button border
                      ),
                    ),
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500, // Medium
                        fontSize: 16.0, // Adjust the font size as needed
                        color: Color(0xFFFFFAFA), // Text color
                      ),
                    ),
                  ),
                ],
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

              // ElevatedButton( onPressed: () {   }, child:Image.asset('icon/home.ico',height: 30,width: 30,) ),
            ],
          ),
        ),
      ),
    );
  }
}
