import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/features/auth/controllers/auth_gate.dart';
import 'package:minimal_chat_app/firebase_options.dart';
import 'package:minimal_chat_app/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Chat App',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: AuthGate(),
    );
  }
}
