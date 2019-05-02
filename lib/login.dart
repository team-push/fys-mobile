import 'package:finish_your_story/join.dart';
import 'package:finish_your_story/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
  }

  _login() {

    String username = usernameController.text;
    String password = passwordController.text;
    AuthService().login(username, password).then((Response response) {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: new InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
              )
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: new InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password'
              )
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                        "Create new account",
                        textAlign: TextAlign.center
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JoinPage()),
                      )
                    },
                  )
                ],
              ),
            ),
            RaisedButton(
              child: const Text('Login'),
              onPressed: _login,
            )
          ],
        )
      )
    );
  }
}