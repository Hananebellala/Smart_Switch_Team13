// ignore_for_file: use_key_in_widget_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_switch_team13/features/HomePage/index.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Submit extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const Submit({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SubmitState createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  late MqttServerClient mqttClient;

  @override
  void initState() {
    super.initState();
    _connectToMqtt();
  }

  void _connectToMqtt() async {
    final String mqttServer = 'test.mosquitto.org';
    final int mqttPort = 1883;
    final String clientId = 'Hanane';

    mqttClient = MqttServerClient(mqttServer, clientId);
    mqttClient.port = mqttPort;

    try {
      await mqttClient.connect();
      print('Connected to MQTT broker');
    } catch (e) {
      print('Failed to connect to MQTT broker: $e');
    }
  }

  void _sendToMqttTopic(String message, String topic) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    mqttClient.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  @override
  void dispose() {
    mqttClient.disconnect();
    super.dispose();
  }

  void _handleSubmit() {
    final wifiName = widget.emailController.text;
    final password = widget.passwordController.text;

    if (wifiName.isEmpty || password.isEmpty) {
      // Show an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter WiFi name and password'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Send data to MQTT topics
      _sendToMqttTopic(wifiName, 'projet13/wifi_name');
      _sendToMqttTopic(password, 'projet13/password');

      // Navigate to the homepage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 100.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF6900FF),
          minimumSize: const Size(double.infinity, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _handleSubmit,
        child: const Text('Submit to MQTT'),
      ),
    );
  }
}

class Wifiname extends StatefulWidget {
  final TextEditingController controller;
  const Wifiname({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _WifinameState createState() => _WifinameState();
}

class _WifinameState extends State<Wifiname> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFFAFA),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6900FF), width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Wifiname',
        hintText: 'Wifi name',
        labelStyle:
            const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300),
      ),
      onChanged: (value) {
        setState(() {}); // Trigger rebuild to maintain focus
      },
    );
  }
}

class Password extends StatefulWidget {
  final TextEditingController controller;
  const Password({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFFAFA),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6900FF), width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 100, 99, 99), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Password',
        hintText: 'Wifi password',
        labelStyle:
            const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300),
      ),
      onChanged: (value) {
        setState(() {}); // Trigger rebuild to maintain focus
      },
    );
  }
}

class Submitbox extends StatefulWidget {
  const Submitbox({Key? key});

  @override
  _SubmitboxState createState() => _SubmitboxState();
}

class _SubmitboxState extends State<Submitbox> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.40,
        width: MediaQuery.of(context).size.width * 0.800,
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7FF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Wifiname(controller: _emailController),
              const SizedBox(height: 20),
              Password(controller: _passwordController),
              const SizedBox(height: 20),
              Submit(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Wifi extends StatelessWidget {
  const Wifi({Key? key});

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFAFA),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 57.0), // Add top padding here
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Wifi Information',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          height: 1,
                          letterSpacing: 0.15,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                    height:
                        30), // Add additional space between "Wifi Information" and "Submitbox"
                Container(
                  width: 377 * fem,
                  height: 650 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  child: Column(
                    children: [
                      const Flexible(
                        child: Submitbox(),
                      ),
                      const SizedBox(height: 0),
                      SizedBox(
                        width: 224,
                        height: 224,
                        child: Image.asset(
                          'images/Wifi.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Pair extends StatelessWidget {
  const Pair({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    double ffem = 1.0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xfffff9f9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 34 * fem),
                      child: const Text(
                        'Home location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30, // no need to multiply by ffem
                          fontWeight: FontWeight.w400,
                          height: 1, // no need to divide by fem
                          letterSpacing: 0.15,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 10 * fem, 0 * fem, 30 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 347 * fem,
                      ),
                      child: const Text(
                        'Setting up your location helps display information like the local weather and use sun-based automations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.51, // no need to multiply by ffem
                          fontWeight: FontWeight.w300,
                          height: 1, // no need to divide by fem
                          letterSpacing:
                              0.0926, // rounded to four decimal places
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 15 * fem, 0 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          10 * fem, 20 * fem, 18 * fem, 9 * fem),
                      width: 340 * fem,
                      height: 55 * fem,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff000000)),
                        color: const Color(0xFFFAF7FF),
                        borderRadius: BorderRadius.circular(10 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x70000000),
                            offset: Offset(0 * fem, 2 * fem),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 10 * fem),
                            width: 40 * fem, // Increased size of the image
                            height: 40 * fem, // Increased size of the image
                            child: Image(
                              width: 400 * fem, // Increased size of the image
                              height: 400 * fem, // Increased size of the image
                              image: const AssetImage('images/search.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            // ignore: avoid_unnecessary_containers
                            child: Container(
                              // Added padding to the TextField
                              child: TextField(
                                textAlignVertical: TextAlignVertical
                                    .center, // Centered the hintText vertically
                                decoration: InputDecoration(
                                  hintText: 'Search Address',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.06 * fem,
                                    color: const Color(0x99000000),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12 * fem,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.06 * fem,
                                  color: const Color(0x99000000),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 377 * fem,
                height: 500 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * fem),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: -80 * fem,
                      bottom: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          heightFactor: 0.9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10 * fem),
                            child: Image.asset(
                              'images/Basemap.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 280,
                      child: Container(
                        width: 200, // Adjusted width (1/4 of Basemap width)
                        height: 200, // Adjusted height (1/4 of Basemap height)
                        child: Image.asset(
                          'images/review-bro.png',
                          width: 200, // Set width to match container width
                          height: 200, // Set height to match container height
                          fit: BoxFit.contain, // Maintain aspect ratio
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20 *
                          fem, // Adjusted right position for the "Next" button
                      top: 330 *
                          fem, // Adjusted bottom position for the "Next" button
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Wifi(),
                            ),
                          );
                        },
                        child: Container(
                          width: 85 * fem,
                          height: 39 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff6900ff),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1 * ffem / fem,
                                letterSpacing: 0.09 * fem,
                                color: const Color(0xfffff9f9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
