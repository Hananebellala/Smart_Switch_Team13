import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/Settings/index.dart';
import 'package:smart_switch_team13/features/HomePage/index.dart';
import 'package:smart_switch_team13/features/LogoPage/index.dart';
import 'package:smart_switch_team13/features/authentification/widget_tree.dart';
import 'package:smart_switch_team13/firebase_options.dart';
import 'features/authentification/index.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream for monitoring authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Example function for signing in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // Example function for signing out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Switch it',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins', // Specify the Poppins font family directly
      ),
      home: WidgetTree(), // Start with the settings page as the home screen
    );
  }
}
