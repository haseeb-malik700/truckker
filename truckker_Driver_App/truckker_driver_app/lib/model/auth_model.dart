import 'package:truckker_driver_app/locator.dart';
import 'package:truckker_driver_app/services/auth_service.dart';
import 'package:truckker_driver_app/view_states.dart';

import 'base_model.dart';


class AuthModel extends BaseModel {
  final Auth _fetchData = locator<Auth>();
  
  
  
    Future<void> signup(String userName, String email, String password) async {
      setState(ViewState.Busy);
      await _fetchData.signUp(userName,email,password);
      setState(ViewState.Idle);
    }
  
    Future<bool> logIn(String identifier, String password) async {
       setState(ViewState.Busy);
       bool val = await _fetchData.login(identifier, password);
       setState(ViewState.Idle);
       return val;
    }
  
    

}