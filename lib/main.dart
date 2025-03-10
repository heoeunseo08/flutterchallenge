import 'package:flutter/material.dart';
import 'package:flutterchallenge/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFf9f9fd),
      ),
      home: HomeScreen(),
    );
  }
}
