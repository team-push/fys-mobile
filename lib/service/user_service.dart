
import 'package:http/http.dart' as http;

class UserService {
  Future<http.Response> getUser(String username) {
    return http.get('http://10.0.2.2:8100/api/user/' + username, headers: {
      'Content-Type': 'application/json'
    }).then((http.Response response) {
    });
  }
}