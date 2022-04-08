import 'package:Truckker/Animations/FadeAnimation.dart';
import 'package:Truckker/locator.dart';
import 'package:Truckker/models/auth_model.dart';
import 'package:Truckker/pages/base_page.dart';
import 'package:Truckker/pages/home_page.dart';
import 'package:Truckker/services/auth_service.dart';
import 'package:Truckker/services/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view_states.dart';

class LoginAnimation extends StatefulWidget {
  @override
  _LoginAnimationState createState() => _LoginAnimationState();
}

class _LoginAnimationState extends State<LoginAnimation> {
  String username = '';
  String password = '';
  Color buttonColor = Colors.grey[700];
  final AuthService _auth = AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final double containerWidth = deviceWidth - targetPadding * 2;

    return Scaffold(
      // backgroundColor: Color.fromRGBO(26, 65, 96, 1),
      backgroundColor: Colors.grey[50],
      body: isLoading
          ?  Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                      1.2,
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromRGBO(26, 65, 96, 1),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.5, _buildUsernameTf(containerWidth, deviceWidth)),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.5, _buildPasswordTf(containerWidth, deviceWidth)),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FadeAnimation(
                        1.8,
                        Center(child: _builButton(username, password)),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }

  Widget _builButton(String id, String password) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      onPressed: () async {
        setState(() {
          isLoading = !isLoading;
        });
        String userId =
            await _auth.signInWithEmailAndPassword(username, password);
        if (userId != '') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(userId),
              ));
        }
        setState(() {
          isLoading = !isLoading;
        });
      },
    );
  }

  Widget _buildUsernameTf(double containerWidth, double deviceWidth) {
    return Container(
      height: 45,
      width: containerWidth,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Color.fromRGBO(26, 65, 96, 1),
          ),
        ),
      ),
      child: SizedBox(
        width: deviceWidth / 1.5,
        child: new TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (String val) {
            setState(() {
              username = val;
              if (username != null) {
                buttonColor = Theme.of(context).primaryColor;
              } else {
                buttonColor = Colors.grey[700];
              }
            });
          },
          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            hintText: "Email or Phone number",
            focusColor: Color.fromRGBO(26, 65, 96, 1),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTf(double containerWidth, double deviceWidth) {
    return Container(
      height: 45,
      width: containerWidth,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Color.fromRGBO(26, 65, 96, 1),
          ),
        ),
      ),
      child: SizedBox(
        width: deviceWidth / 1.5,
        child: new TextField(
          obscureText: true,
          keyboardType: TextInputType.number,
          onChanged: (String val) {
            setState(() {
              password = val;
            });
          },
          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            hintText: "Password",
            focusColor: Color.fromRGBO(26, 65, 96, 1),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
