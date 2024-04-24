import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'about_screen.dart';
import 'order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(), // runs the main screen of application
    );
  }
}
