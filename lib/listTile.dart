import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MessagesPage(),
    );
  }
}

class MessagesPage extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {'name': 'nada ali', 'message': 'hello ahmed how?', 'time': '22:30', 'url': 'assets/avatar1.jpg'},
    {'name': 'ahmed ali', 'message': 'hello muhammad how?', 'time': '19:20', 'url': 'assets/avatar2.jpg'},
    // Add more message entries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < messages.length; i++)
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(messages[i]['url']!),
                  radius: 30,
                ),
                title: Text(messages[i]['name']!),
                subtitle: Text(messages[i]['message']!),
                trailing: Text(messages[i]['time']!),
              ),
          ],
        ),
      ),
    );
  }
}