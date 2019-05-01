import 'package:finish_your_story/join.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
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
              decoration: new InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
              )
            ),
            TextFormField(
              obscureText: true,
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
              onPressed: () => {
                print("login...")
              },
            )
          ],
        )
      )
    );
  }
}