import 'package:backend_pratice/Api_Login/Login_Api.dart';
import 'package:backend_pratice/dashboard/C_Json.dart';
import 'package:backend_pratice/dashboard/ImageApi.dart';
import 'package:backend_pratice/dashboard/complex_json.dart';
import 'package:backend_pratice/login/VerifyCode.dart';
import 'package:backend_pratice/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue
      ),
      home: LoginApi(),
    );
  }
}
