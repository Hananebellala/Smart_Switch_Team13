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
import 'package:smart_switch_team13/features/Settings/screens/notification.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'next_homepage.dart';

import '../widgets/boutton/home_boutton.dart';
import '../widgets/boutton/paramettre_boutton.dart';
import '../widgets/boutton/controle_Boutton.dart';
import '../widgets/boutton/scence_boutton.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/ajouter_box.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _refreshData() async {}
  String _username = 'User';

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  late MqttServerClient mqttClient;

  

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText(); // Initialize _speech here
    initializeSpeechRecognition();
    _connectToMqtt();
    _loadUsername();
    
  }



  Future<void> _loadUsername() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );


    final List<Map<String, dynamic>> users = await database.rawQuery('SELECT * FROM users');


    if (users.isNotEmpty) {
      setState(() {
        _username = users.first['username'];
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(),
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30),
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
                          'Good Morning,',
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          ' $_username',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Container(
                  height: 40,
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width * 0.11,
                  child: IconButton(
                    icon: Image.asset(
                      'icon/notifcations.ico',
                      height: 25,
                      width: 25,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()),
                      );
                    },
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.001),
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 30,
                    child: IconButton(
                      icon: const Icon(Icons.person,
                          color: Color(0xFF6900FF), size: 30.0),
                      onPressed: () {},
                    ),
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
