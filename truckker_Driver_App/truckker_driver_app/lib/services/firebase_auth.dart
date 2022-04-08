
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truckker_driver_app/objects/loggedInUserInfo.dart';
import 'package:truckker_driver_app/services/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(id: user.uid) : null;
  }


  Future<String> currentUserIdFromAuth() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;
    if (uid.isNotEmpty)
      return uid;
    else
      return "";
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
