import 'package:flutter/material.dart';
/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();

  Future<void> signUp() async {
    try {
      // Create user with email and password
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);

      // Get user id
      final String userId = userCredential.user!.uid;

      // Store additional user details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email.text,
        'username': username.text,
        // Add more fields as needed
      });

      // Reset text controllers
      email.clear();
      password.clear();
      username.clear();

      // Show success message
      Get.snackbar('Success', 'Account created successfully');
    } catch (error) {
      // Show error message
      Get.snackbar('Error', 'Failed to create account: $error');
    }
  }
} */
