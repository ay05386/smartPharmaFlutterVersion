import 'package:flutter/material.dart';
import '../localDataBase/localUserDB.dart';

class AppDrawer extends StatelessWidget {
  final UserDB userDB;
  final Map<String, dynamic> userData;
  final VoidCallback onLogout;

  AppDrawer({required this.userDB, required this.userData, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userData['name']),
            accountEmail: Text(userData['email']),
            currentAccountPicture: CircleAvatar(
              child: Text(userData['name'][0].toUpperCase()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Stock'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/stock');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
