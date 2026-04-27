import 'package:cap_and_gown/Done/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://brddyzzgeirwqaxpdfhu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJyZGR5enpnZWlyd3FheHBkZmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzcyOTgyMDksImV4cCI6MjA5Mjg3NDIwOX0.0zkgdcdUGTUoOQigTNS4a5z7XVm11X_xfPM4309SiwM',
  );

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
