import 'package:flutter/material.dart';
import '../localDataBase/localUserDB.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late UserDB userDatabase;
  bool T = true;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDatabase = UserDB();
    userDatabase.CreateDatabaseAndTables();
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: Colors.black, fontSize: 30)),
          content: Text(content, style: TextStyle(color: Colors.black, fontSize: 30)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.black, fontSize: 30)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp", style: TextStyle(color: Colors.black, fontSize: 25)),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          //NAME TEXT FORM FIELD
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.supervised_user_circle),
                  hintText: 'Write your name',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 25),
                  label: Text('Name', style: TextStyle(color: Colors.black, fontSize: 30))),
            ),
          ),
          //EMAIL TEXT FORM FIELD
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email_outlined),
                  hintText: 'Write your email',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 25),
                  label: Text('Email', style: TextStyle(color: Colors.black, fontSize: 30))),
            ),
          ),
          //PASSWORD TEXT FORM FIELD
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              obscureText: T,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        T = !T;
                      });
                    },
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  hintText: 'Write your password',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 25),
                  label: Text('Password', style: TextStyle(color: Colors.black, fontSize: 25))),
            ),
          ),
          //SIGNUP BUTTON
          MaterialButton(
            color: Colors.orange,
            onPressed: () async {
              await userDatabase.insertUser(
                  name: name.text, email: email.text, password: password.text);
              _showDialog('Success', 'SignUp successful!');
            },
            child: Text("SignUp", style: TextStyle(color: Colors.black, fontSize: 25)),
          ),
        ],
      ),
    );
  }
}
