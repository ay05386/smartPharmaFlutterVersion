import 'package:flutter/material.dart';
import 'package:first/models/Chat.dart';
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
  final List<Chat> list = [
    Chat(
      url: 'assets/images/image0.jpg',
      title: 'Ahmed',
      message: 'whatsapp',
      time: '1:00',
    ),
    Chat(
      url: 'assets/images/image1.jpg',
      title: 'Noor',
      message: 'whatsapp',
      time: '2:00',
    ),
    Chat(
      url: 'assets/images/image2.jpg',
      title: 'Khaled',
      message: 'whatsapp',
      time: '3:00',
    ),
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
                      backgroundImage: AssetImage(list[i].url),
                    ),
                    title: Text(list[i].title),
                    subtitle: Text(list[i].message),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBar(title: Text('Chat Details')),
                              body: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Name: ${list[i].title}'),
                                    Text('Message: ${list[i].message}'),
                                    Text('Time: ${list[i].time}'),
                                    Image.asset(list[i].url),
                                  ],
                                ),
                              ),
                            );
                          },
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
