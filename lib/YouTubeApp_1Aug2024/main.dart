import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'home_screen.dart';
import 'subscription_screen.dart';
import 'you_screen.dart';
import 'main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
