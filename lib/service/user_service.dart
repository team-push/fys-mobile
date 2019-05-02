
import 'package:http/http.dart' as http;

class UserService {
  Future<http.Response> getUser(String username) {
    return http.get('http://3.91.208.51/api/user/' + username, headers: {
      'Content-Type': 'application/json'
    }).then((http.Response response) {
    });
  }
}