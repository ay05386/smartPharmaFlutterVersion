import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'user_database.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT, url TEXT)',
      );
      await db.execute(
        'CREATE TABLE department (depart_id INTEGER PRIMARY KEY, depart_name TEXT, user_id INTEGER, FOREIGN KEY (user_id) REFERENCES user(id))',
      );
    },
    version: 1,
  );
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Database database;

  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(database: database),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Database database;

  const HomeScreen({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Database App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Add User'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserScreen(database: database)),
                );
              },
            ),
            ElevatedButton(
              child: Text('Add Department'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDepartmentScreen(database: database)),
                );
              },
            ),
            ElevatedButton(
              child: Text('Show All Data'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowDataScreen(database: database)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddUserScreen extends StatelessWidget {
  final Database database;
  final nameController = TextEditingController();
  final departmentController = TextEditingController();
  final userIdController = TextEditingController();

  AddUserScreen({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: departmentController, decoration: InputDecoration(labelText: 'Department')),
            TextField(controller: userIdController, decoration: InputDecoration(labelText: 'User ID')),
            ElevatedButton(
              child: Text('Add User'),
              onPressed: () async {
                await database.insert('user', {
                  'id': int.parse(userIdController.text),
                  'name': nameController.text,
                  'email': '',
                  'password': '',
                  'url': '',
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddDepartmentScreen extends StatelessWidget {
  final Database database;
  final idController = TextEditingController();
  final nameController = TextEditingController();

  AddDepartmentScreen({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Department')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: idController, decoration: InputDecoration(labelText: 'Department ID')),
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Department Name')),
            ElevatedButton(
              child: Text('Add Department'),
              onPressed: () async {
                await database.insert('department', {
                  'depart_id': int.parse(idController.text),
                  'depart_name': nameController.text,
                  'user_id': null,
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShowDataScreen extends StatelessWidget {
  final Database database;

  const ShowDataScreen({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Data')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map>>(
              future: database.query('department'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Department: ${snapshot.data![index]['depart_name']}'),
                      subtitle: Text('ID: ${snapshot.data![index]['depart_id']}'),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map>>(
              future: database.query('user'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('User: ${snapshot.data![index]['name']}'),
                      subtitle: Text('ID: ${snapshot.data![index]['id']}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}