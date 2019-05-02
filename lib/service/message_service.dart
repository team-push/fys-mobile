import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  String username;

  User({this.username});

  factory User.fromMap(Map<String, dynamic> map) => new User(
    username: map['username']
  );
}
class PushMessage {
  int id;
  String message;
  User userFrom;
  User userTo;

  PushMessage({this.id, this.message, this.userFrom, this.userTo});

  factory PushMessage.fromMap(Map<String, dynamic> map) => new PushMessage(
    id: map['id'],
    message: map['message']
  );
}

class MessageService {
  Future<http.Response> send(String to, String message) async {
    final storage = new FlutterSecureStorage();
    String accessKey = await storage.read(key: 'accessKey');
    Map<String, dynamic> map = new Map();
    map['message'] = message;
    return http.post('http://10.0.2.2:8100/api/message/to/' + to, headers: {
      'Authorization': 'Bearer ' + accessKey
    }, body: map).then((http.Response response){
      print(response.statusCode);
      print(response.body);
    });
  }
  Future<http.Response> getMessages() async {
    final storage = new FlutterSecureStorage();
    String accessKey = await storage.read(key: 'accessKey');
    return http.get('http://10.0.2.2:8100/api/message', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + accessKey
    }).then((http.Response response) {
      print(response.body);
      var list = json.decode(response.body) as List;
      for (Map<String, dynamic> value in list) {
        print(value);
        NotificationService().notify(PushMessage.fromMap(value));
      }
    });
  }
}

class NotificationService {
  notify(PushMessage pushMessage) {
    Future onSelectNotification(String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
    }
    Future onDidRecieveLocationLocation(int id, String title, String body, String payload) async {
      if (payload != null) {
        print('payload: ' + payload);
      }
    }

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocationLocation);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);


    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'push notification', 'push messages',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
        0, 'Push Notification', pushMessage.message, platformChannelSpecifics,
        payload: 'item id 2');
  }
}