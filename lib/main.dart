import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_ddd_2024/Presentation_/screens/login_screen.dart';
import 'package:weather_bloc_ddd_2024/firebase_options.dart';

import 'Presentation_/Bloc/weather_bloc.dart';
import 'Presentation_/screens/weather_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Replace the placeholder options with your actual Firebase options
  FirebaseOptions firebaseOptions = DefaultFirebaseOptions.currentPlatform;

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}