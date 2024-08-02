import 'package:flutter/material.dart';

class YouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          'You',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
