import 'package:finish_your_story/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}
class _JoinPageState extends State<JoinPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();

  _join() {
    setState(() {

      if(passwordController.text != confirmPasswordController.text) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Password does not match!!"),
              );
            }
        );
      }
      AuthService().register(usernameController.text, passwordController.text, fullNameController.text);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Join')
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
                labelText: 'Password',
              )
            ),
            TextFormField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: new InputDecoration(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                )
            ),
            TextFormField(
              controller: fullNameController,
              decoration: new InputDecoration(
                hintText: 'Full Name',
                labelText: 'Full Name',
              )
            ),
            RaisedButton(
              child: const Text('Join'),
              onPressed: () {
                if (passwordController.text != confirmPasswordController.text) {
                    return showDialog(
                    context: context,
                    builder: (context) {
                    return AlertDialog(
                    content: Text("Password does not match!!"),
                    );
                  }
                  );
                } else {
                  AuthService().register(usernameController.text, passwordController.text, fullNameController.text)
                      .then((Response response) {
                          Navigator.pushNamed(context, '/login');
                      });
                }
              },
            )
          ],
        )
      ),
    );
  }
}