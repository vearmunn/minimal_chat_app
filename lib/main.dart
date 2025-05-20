import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_chat_app/features/auth/controllers/auth_gate.dart';
import 'package:minimal_chat_app/features/auth/controllers/bloc/auth_bloc.dart';
import 'package:minimal_chat_app/features/chat/controllers/chatting/chat_bloc.dart';
import 'package:minimal_chat_app/features/chat/controllers/send_message/send_message_cubit.dart';
import 'package:minimal_chat_app/features/chat/controllers/users/users_bloc.dart';
import 'package:minimal_chat_app/features/profile/controllers/bloc/profile_bloc.dart';
import 'package:minimal_chat_app/firebase_options.dart';
import 'package:minimal_chat_app/themes/dark_mode.dart';
import 'package:minimal_chat_app/themes/light_mode.dart';

import 'themes/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(
          create: (context) => AuthBloc(auth: auth, firestore: firestore),
        ),
        BlocProvider(
          create: (context) => UsersBloc(auth: auth, firestore: firestore),
        ),
        BlocProvider(
          create: (context) => ChatBloc(auth: auth, firestore: firestore),
        ),
        BlocProvider(
          create:
              (context) => SendMessageCubit(auth: auth, firestore: firestore),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(auth: auth, firestore: firestore),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<ThemeBloc>().add(LoadTheme());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Minimal Chat App',
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: state.themeMode,
          home: AuthGate(),
        );
      },
    );
  }
}
