import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MessageScreen(),
    );
  }
}

class MessageScreen extends StatelessWidget {
  List<Map> list = [
    {
      'name': 'Ahmed',
      'url': 'assets/images/image0',
      'message': 'whatsapp',
      'time': '1:00',
    },
    {
      'name': 'Noor',
      'url': 'assets/images/image1',
      'message': 'whatsapp',
      'time': '2:00',
    },
    {
      'name': 'khaled',
      'url': 'assets/images/image2',
      'message': 'whatsapp',
      'time': '3:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < list.length; i++)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(list[i]['url']!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list[i]['name']!),
                              Text(list[i]['message']!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}