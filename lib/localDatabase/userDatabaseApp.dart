import 'package:flutter/material.dart';
import 'userDatabase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management App',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Management')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text('Insert'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InsertScreen()));
            },
          ),
          ElevatedButton(
            child: Text('Update'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen()));
            },
          ),
          ElevatedButton(
            child: Text('Delete'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteScreen()));
            },
          ),
          ElevatedButton(
            child: Text('Show All Users'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class InsertScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert User')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: idController, decoration: InputDecoration(labelText: 'ID')),
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            ElevatedButton(
              child: Text('Insert'),
              onPressed: () async {
                await DatabaseHelper.instance.insert({
                  DatabaseHelper.columnId: int.parse(idController.text),
                  DatabaseHelper.columnName: nameController.text,
                  DatabaseHelper.columnEmail: emailController.text,
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

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update User')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: idController, decoration: InputDecoration(labelText: 'Search ID')),
            ElevatedButton(
              child: Text('Search'),
              onPressed: () async {
                final user = await DatabaseHelper.instance.queryUser(int.parse(idController.text));
                if (user.isNotEmpty) {
                  setState(() {
                    nameController.text = user.first[DatabaseHelper.columnName];
                    emailController.text = user.first[DatabaseHelper.columnEmail];
                  });
                }
              },
            ),
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            ElevatedButton(
              child: Text('Update'),
              onPressed: () async {
                await DatabaseHelper.instance.update({
                  DatabaseHelper.columnId: int.parse(idController.text),
                  DatabaseHelper.columnName: nameController.text,
                  DatabaseHelper.columnEmail: emailController.text,
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

class DeleteScreen extends StatelessWidget {
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delete User')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: idController, decoration: InputDecoration(labelText: 'Search ID')),
            ElevatedButton(
              child: Text('Search'),
              onPressed: () async {
                final user = await DatabaseHelper.instance.queryUser(int.parse(idController.text));
                if (user.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('User Found'),
                      content: Text('ID: ${user.first[DatabaseHelper.columnId]}\nName: ${user.first[DatabaseHelper.columnName]}\nEmail: ${user.first[DatabaseHelper.columnEmail]}'),
                      actions: [
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () async {
                            await DatabaseHelper.instance.delete(int.parse(idController.text));
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShowAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Users')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.queryAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index][DatabaseHelper.columnName]),
                subtitle: Text(snapshot.data![index][DatabaseHelper.columnEmail]),
                leading: Text(snapshot.data![index][DatabaseHelper.columnId].toString()),
              );
            },
          );
        },
      ),
    );
  }
}