import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 70,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      13,
                          (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: Image.asset('assets/images/image$index.jpg').image,
                              radius: 22,
                            ),
                            SizedBox(height: 4),
                            Text('name', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 13,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: Image.asset('assets/images/image$index.jpg').image,
                      radius: 20,
                    ),
                    title: Text('name'),
                    subtitle: Text('message'),
                    trailing: Text('time'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
