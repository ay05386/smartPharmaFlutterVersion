import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Home',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
