import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Registration {
  String username;
  String password;
  String fullName;

  Registration({this.username, this.password, this.fullName});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'fullName': fullName
  };
}
class Login {
  String username;
  String password;

  Login({this.username, this.password});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password
  };
}
class AuthService {
  Future<http.Response> register(String username, String password, String fullName) {
    var reg = Registration(username: username, password: password, fullName: fullName);
    return http.post('http://3.91.208.51/api/auth/register', headers: {
      'Content-Type': 'application/json'
    }, body: json.encode(reg.toJson())).then((http.Response response) {
      print(response.statusCode);
    });
  }
  Future<http.Response> login(String username, String password) {
    var login = Login(username: username, password: password);
    return http.post('http://3.91.208.51/api/auth/login', headers: {
      'Content-Type': 'application/json'
    }, body: json.encode(login.toJson())).then((http.Response response) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final storage = new FlutterSecureStorage();
      storage.write(key: 'accessKey', value: map['accessToken']);
    });
  }
}