import 'package:cap_and_gown/Home/home_screen.dart';
import 'package:cap_and_gown/sign_up_screen.dart';
import 'package:cap_and_gown/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Signup Page',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF131722),
      ),
      home: const WelcomeScreen(),
    );
  }
}
