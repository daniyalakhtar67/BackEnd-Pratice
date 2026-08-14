import 'dart:async';

import 'package:backend_pratice/bottomNav/bottomNavigator.dart';
import 'package:backend_pratice/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    Timer(const Duration(seconds: 3), () {
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          user != null ? Bottomnavigator() : LoginScreen(),
        ),
      );
    });
  }
}