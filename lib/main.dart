import 'package:flutter/material.dart';
import 'package:khushi_flutter_practice/Authencation/login_screen.dart';
import 'package:khushi_flutter_practice/Authencation/otp_verification.dart';
import 'package:khushi_flutter_practice/Authencation/phone_login_screen.dart';
import 'package:khushi_flutter_practice/Screens/home_screen.dart';
import 'package:khushi_flutter_practice/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

