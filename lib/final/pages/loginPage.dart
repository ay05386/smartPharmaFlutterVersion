import 'package:first/final/pages/signUpPage.dart';
import 'package:flutter/material.dart';
import '../localDataBase/localUserDB.dart';
import 'homePage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  bool T = true;
  late UserDB userDatabaseLogin;

  @override
  void initState() {
    super.initState();
    userDatabaseLogin = UserDB();
    userDatabaseLogin.CreateDatabaseAndTables();
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
        title: Text("Login", style: TextStyle(color: Colors.black, fontSize: 25)),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          //EMAIL FIELD
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                  hintText: 'Write your email',
                  label: Text('Email', style: TextStyle(color: Colors.black, fontSize: 30))),
            ),
          ),
          //PASSWORD FIELD
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              obscureText: T,
              controller: password,
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
                  label: Text('Password', style: TextStyle(color: Colors.black, fontSize: 25))),
            ),
          ),
          //DON'T HAVE ACCOUNT NAVIGATE TO SIGNUP
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 40),
                  Text("Don't have an account?", style: TextStyle(color: Colors.black, fontSize: 25)),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return SignUp();
                      }));
                    },
                    child: Text("SignUp",
                        style: TextStyle(color: Colors.blue, fontSize: 25, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ],
          ),
          MaterialButton(
            color: Colors.orange,
            onPressed: () async {
              bool isValidUser = false;
              List<Map> users = await userDatabaseLogin.showData();
              for (int i = 0; i < users.length; i++) {
                if (users[i]['email'] == email.text && users[i]['password'] == password.text) {
                  isValidUser = true;
                  _showDialog('Success', 'Login successful!');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                  break;
                }
              }
              if (!isValidUser) {
                _showDialog('Error', 'Incorrect email or password. Please try again.');
              }
            },
            child: Text("Login", style: TextStyle(color: Colors.black, fontSize: 25)),
          ),
        ],
      ),
    );
  }
}
