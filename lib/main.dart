import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:finish_your_story/login.dart';
import 'package:finish_your_story/service/message_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() async {

  Widget _defaultHome = new LoginPage();

  bool checkLogin = false;
  if(checkLogin) {
    _defaultHome = MyHomePage();
  }

  final int alarmId = 0;
  await AndroidAlarmManager.initialize();
  runApp(new MaterialApp(
    title: 'GO FYSH',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new MyHomePage(),
      '/login': (BuildContext context) => new LoginPage()
    },
  ));
  await AndroidAlarmManager.periodic(const Duration(seconds: 5), alarmId, checkMessage,
    wakeup: true, exact: true);
}

void checkMessage() {
  MessageService().getMessages().then((Response response) {

  });
  print("hello checking now..");
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GO FYSH',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String _username = "";

  void _push() {
    setState(() {
      _username = userSearchController.text;
      if(_username == "") {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("please input username"),
              );
            }
        );
      } else {
        print("sending to " + _username + ", message=" + _selectedMessage);
        MessageService().send(_username, _selectedMessage);
      }
    });
  }

  String _selectedMessage;

  final userSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _selected1(String value) {
      setState(() {
        _selectedMessage = value;
      });
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("GO FYSH"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          TextFormField(
            controller: userSearchController,
            decoration: new InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              prefixIcon: Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ), // icon is 48px widget.
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
          ),
          Center(
            child: InkWell(
                onTap: _push,
                child: Container(
                    padding: const EdgeInsets.all(50.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54
                    ),
                    child: Text("PUSH", style: TextStyle(color: Colors.white, fontSize: 50.0))
                )
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: 'Finish your stories.',
                    groupValue: _selectedMessage,
                    onChanged: _selected1,
                  ),
                  new Text(
                    'Finish Your Story Now!!',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'Zero out your hours',
                    groupValue: _selectedMessage,
                    onChanged: _selected1,
                  ),
                  new Text(
                    'Zero out your hours',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'Change your due date.',
                    groupValue: _selectedMessage,
                    onChanged: _selected1,
                  ),
                  new Text(
                    'Change your due date.',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'This story is too old.',
                    groupValue: _selectedMessage,
                    onChanged: _selected1,
                  ),
                  new Text(
                    'This story is too old',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: "I'm working from home",
                    groupValue: _selectedMessage,
                    onChanged: _selected1,
                  ),
                  new Text(
                    "I'm working from home",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              )
            ],
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
