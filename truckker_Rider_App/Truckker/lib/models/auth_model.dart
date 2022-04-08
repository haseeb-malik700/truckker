import 'package:Truckker/locator.dart';
import 'package:Truckker/models/base_model.dart';
import 'package:Truckker/services/auth_service.dart';
import 'package:Truckker/view_states.dart';

class AuthModel extends BaseModel {
  final Auth _fetchData = locator<Auth>();

  Future<void> signup(String userName, String email, String password) async {
    setState(ViewState.Busy);
    await _fetchData.signUp(userName, email, password);
    setState(ViewState.Idle);
  }

  Future<bool> logIn(String identifier, String password) async {
    setState(ViewState.Busy);
    bool val = await _fetchData.login(identifier, password);
    setState(ViewState.Idle);
    return val;
  }
}
