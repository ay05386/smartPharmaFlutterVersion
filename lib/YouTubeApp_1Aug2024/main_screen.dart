import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'subscription_screen.dart';
import 'you_screen.dart';

class MainScreen extends StatelessWidget {
  final Map<String, String> user;

  MainScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Youtube App'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.subscriptions)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user['name']!),
                accountEmail: Text(user['email']!),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/image5.jpg'),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            SubscriptionScreen(),
            YouScreen(),
          ],
        ),
      ),
    );
  }
}
