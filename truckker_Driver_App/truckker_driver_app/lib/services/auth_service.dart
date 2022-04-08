
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:truckker_driver_app/objects/loggedInUserInfo.dart';


class Auth {
  StreamController<LoggedInUserInfo> _userStream =  StreamController.broadcast();

  Stream<LoggedInUserInfo> get userData => _userStream.stream;

  LoggedInUserInfo userInfo;
  String url = 'http://192.168.10.10:1337/auth/local/register';


  Future<void> signUp(String userName, String email, String password) async{
    print("this");
    print(email);
    print(userName);
    print(password);
    Response response = await post('http://192.168.10.10:1337/auth/local/register', body: {
      "username" : userName,
      "email" : email,
      "password": password
      }
    );
   // int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
    String body = response.body ;
    print(body);

  }


  Future<bool> login(String identifier, String password) async{
    
    Response response = await post('http://192.168.10.10:1337/auth/local', body: {
      "identifier": identifier, 
      "password": password,
      }
    );
    int statusCode = response.statusCode;
    var data = json.decode(response.body);

    userInfo= LoggedInUserInfo.fromJson(data);
    print(userInfo.user.id);
    
    this._userStream.add(userInfo);

   

   print(response.body);

   
  

  // print(rest);
    
    if(statusCode == 200) {
      return true ;
    }
                                                                         
    
    return false;

  }
  

}