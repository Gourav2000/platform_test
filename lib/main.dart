import 'package:flutter/material.dart';
import 'package:platform_test/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform_test',
      home: Home_Page(),
    );
  }
}

