/*import 'package:flutter/material.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/home_boutton.dart';
import '../widgets/boutton/paramettre_boutton.dart';
import '../widgets/boutton/controle_Boutton.dart';
import '../widgets/boutton/scence_boutton.dart';
import 'next_homepage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.035),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.6,
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            'Good Morning,',
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: const Text(
                            'User',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Container(
                  height: 40,
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width * 0.11,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Color(0xFF6900FF),
                        size: 27.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const next_homepage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.001,
                  ),
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: Color(0xFF6900FF),
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const next_homepage(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 150),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment.centerLeft,
                  child: const Text('Connected Devices'),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const next_homepage(),
                        ),
                      );
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                
              ],
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                
              ],
            ),
          ],
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const next_homepage(),
                ),
              );
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
              Home_boutton(pathIcon: 'icon/homeOn.ico'),
              SizedBox(width: 30),
              Controle_boutton(pathIcon: 'icon/controle.ico'),
              SizedBox(width: 90),
              Scence_boutton(pathIcon: 'icon/sCENCE_1.ico'),
              SizedBox(width: 30),
              Paramettre_boutton(pathIcon: 'icon/paramettre.ico'),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_switch_team13/features/HomePage/widgets/box_lampe.dart';
import 'package:smart_switch_team13/features/weather/Pages/weather_page.dart';
import 'package:smart_switch_team13/features/Settings/screens/notification.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:image_picker/image_picker.dart';

import 'next_homepage.dart';

import '../widgets/boutton/home_boutton.dart';
import '../widgets/boutton/paramettre_boutton.dart';
import '../widgets/boutton/controle_Boutton.dart';
import '../widgets/boutton/scence_boutton.dart';
import '../widgets/boutton/add_scence.dart';
import '../widgets/ajouter_box.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Home extends StatefulWidget {
  final String message;
  final bool test;
  final String photo;
  final bool testphoto;
  Home(
      {Key? key,
      this.message = 'User',
      this.test = false,
      this.photo = '',
      this.testphoto = false})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState(
      userEmail: message, test: test, imagePath: photo, testphoto: testphoto);
}

class _HomeState extends State<Home> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  late MqttServerClient mqttClient;

  Future<void> _refreshData() async {}

  late String userEmail = 'Hanane';
  late String imagePath;
  final bool test;
  final bool testphoto;
  _HomeState(
      {required this.userEmail,
      required this.test,
      required this.imagePath,
      required this.testphoto});

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText(); // Initialize _speech here
    initializeSpeechRecognition();
    _connectToMqtt();
    _loadUser2State();
    _loadImagePath();
  }

  Future<void> _loadUser1State() async {
    _loadUser2State();
  }

  Future<void> _loadUser2State() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (test) {
        userEmail = widget.message;
        _saveUser1State(userEmail);
      } else {
        userEmail = prefs.getString(_getUniqueKey()) ?? widget.message;
        _saveUser1State(userEmail);
      }
    });
  }

  Future<void> _saveUser1State(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_getUniqueKey(), value);
  }

  String _getUniqueKey() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return '';
  }

  void _connectToMqtt() async {
    final String mqttServer = 'test.mosquitto.org'; // MQTT broker address
    final int mqttPort = 1883; // MQTT broker port
    final String clientId = 'Hannine'; // Unique client ID

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

  void initializeSpeechRecognition() async {
    bool isAvailable = await _speech.initialize();
    if (!isAvailable) {
      print('Speech recognition not available');
      // Handle speech recognition not available
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

  void _publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    mqttClient.publishMessage(
        'VoiceCommTea13', MqttQos.atMostOnce, builder.payload!);
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

  Future<void> _loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!testphoto) {
      setState(() {
        imagePath = prefs.getString('user_image') ?? '';
      });
      _saveImageState(imagePath);
    } else {
      imagePath = 'image/user_male.png';
      _saveImageState(imagePath);
    }
  }

  Future<void> _saveImageState(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_image', imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(),
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.035),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          'Hey there,',
                          style: TextStyle(
                            fontSize: 33,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          ' $userEmail',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //WeatherPage(), // Here's where you add the WeatherPage widget
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.001),
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 30,
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 120),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Connected Devices',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const next_homepage(),
                        ),
                      );
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ////  const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  Insert(
                    showButtons: false,
                    showlist: true,
                    maxBoxesToShow: 2,
                    maxBoxesPerColumn1: 2,
                    maxBoxesPerColumn2: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Color(0xFF6900FF),
              shape: CircleBorder(),
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
                Home_boutton(pathIcon: 'icon/homeOn.ico'),
                SizedBox(width: 30),
                Controle_boutton(pathIcon: 'icon/controle.ico'),
                SizedBox(width: 90),
                Scence_boutton(pathIcon: 'icon/sCENCE_1.ico'),
                SizedBox(width: 30),
                Paramettre_boutton(pathIcon: 'icon/paramettre.ico'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
