import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}
class _JoinPageState extends State<JoinPage> {
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
                decoration: new InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                )
            ),

            TextFormField(
              obscureText: true,
              decoration: new InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
              )
            ),
            TextFormField(
                obscureText: true,
                decoration: new InputDecoration(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                )
            ),
            TextFormField(
                decoration: new InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                )
            ),
            RaisedButton(
              child: const Text('Join'),
              onPressed: () => {
                print("join...")
              },
            )
          ],
        )
      ),
    );
  }
}