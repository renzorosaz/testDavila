import 'package:flutter/material.dart';
import 'package:test_davila/pages/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlazaVea',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
