import 'package:flutter/material.dart';
import '../localDataBase/localUserDB.dart';
import 'loginPage.dart'; // Import the login page

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late UserDB userDatabase;
  bool _obscurePassword = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDatabase = UserDB();
    userDatabase.CreateDatabaseAndTables();
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
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
          // NAME TEXT FORM FIELD
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.supervised_user_circle),
                hintText: 'Write your name',
                hintStyle: TextStyle(color: Colors.black, fontSize: 25),
                label: Text('Name', style: TextStyle(color: Colors.black, fontSize: 30)),
              ),
            ),
          ),
          // EMAIL TEXT FORM FIELD
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.email_outlined),
                hintText: 'Write your email',
                hintStyle: TextStyle(color: Colors.black, fontSize: 25),
                label: Text('Email', style: TextStyle(color: Colors.black, fontSize: 30)),
              ),
            ),
          ),
          // PASSWORD TEXT FORM FIELD
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                ),
                hintText: 'Write your password',
                hintStyle: TextStyle(color: Colors.black, fontSize: 25),
                label: Text('Password', style: TextStyle(color: Colors.black, fontSize: 25)),
              ),
            ),
          ),
          // SIGNUP BUTTON
          MaterialButton(
            color: Colors.orange,
            onPressed: () async {
              await userDatabase.insertUser(
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
              );
              _navigateToLogin(); // Navigate to login screen upon successful signup
            },
            child: Text("SignUp", style: TextStyle(color: Colors.black, fontSize: 25)),
          ),
        ],
      ),
    );
  }
}
