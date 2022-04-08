import 'dart:async' show Future, StreamController;
import 'dart:convert';
import 'package:Truckker/objects/LoggedInUserInfo.dart';
import 'package:http/http.dart';

class Auth {
  StreamController<LoggedInUserInfo> _userStream = StreamController.broadcast();

  Stream<LoggedInUserInfo> get userData => _userStream.stream;

  LoggedInUserInfo userInfo;
  String url = 'http://192.168.0.2:1337/auth/local/register';

  Future<void> signUp(String userName, String email, String password) async {
    Response response = await post(
        'http://192.168.0.2:1337/auth/local/register',
        body: {"username": userName, "email": email, "password": password});
    // int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body = response.body;
  }

  Future<bool> login(String identifier, String password) async {
    Response response = await post('http://192.168.0.2:1337/auth/local', body: {
      "identifier": identifier,
      "password": password,
    });

    int statusCode = response.statusCode;
    var data = json.decode(response.body);

    userInfo = LoggedInUserInfo.fromJson(data);

    this._userStream.add(userInfo);

    if (statusCode == 200) {
      return true;
    }

    return false;
  }
}
