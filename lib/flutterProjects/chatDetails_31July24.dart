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
  final List<Map> list = [
    {
      'name': 'Ahmed',
      'url': 'assets/images/image0.jpg',
      'message': 'whatsapp',
      'time': '1:00',
    },
    {
      'name': 'Noor',
      'url': 'assets/images/image1.jpg',
      'message': 'whatsapp',
      'time': '2:00',
    },
    {
      'name': 'Khaled',
      'url': 'assets/images/image2.jpg',
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
                child: Card(
                  color: Colors.cyan,
                  shadowColor: Colors.yellow,
                  elevation: 10,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(list[i]['url']!),
                    ),
                    title: Text(list[i]['name']!),
                    subtitle: Text(list[i]['message']!),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatDetails(chat: list[i]),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ChatDetails extends StatelessWidget {
  final Map chat;

  ChatDetails({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${chat['name']}'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Image.asset(chat['url']),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Text(
                    chat['message'],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
