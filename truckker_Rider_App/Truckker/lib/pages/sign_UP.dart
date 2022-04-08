import 'package:Truckker/locator.dart';
import 'package:Truckker/models/FireDatabaseUser.dart';
import 'package:Truckker/models/auth_model.dart';
import 'package:Truckker/pages/base_page.dart';
import 'package:Truckker/pages/contact_detail_page.dart';
import 'package:Truckker/services/auth_service.dart';
import 'package:Truckker/services/firebase_auth.dart';
import 'package:Truckker/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:Truckker/utilities/constants.dart';

import '../view_states.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ViewState _state = ViewState.Idle;

  Auth _authService = locator<Auth>();
  User currentUser = new User();
  bool isLoading = false;
  String userName, password, email, confirmPassword;
  String p1;
  String p2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildFullNamelTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'FullName',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            onSaved: (String value) {
              userName = value;
            },
            validator: (String fullName) {
              if (fullName.isEmpty || fullName.length < 2) {
                return 'Name is required and should be 2+ characters long ';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              hintText: 'Enter your name',
              hintStyle: kHintTextStyle,
            ),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            onSaved: (String value) {
              email = value;
              print('email : ');
            },
            validator: (String email) {
              if (email.isEmpty) {
                //||
                //RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                //.hasMatch(email)) {
                return 'Invalid email address.';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            onFieldSubmitted: (String val) {
              p1 = val;
            },
            obscureText: true,
            onSaved: (String value) {
              password = value;
            },
            validator: (String password) {
              if (password.isEmpty || password.length < 8) {
                //p1=password;
                return 'Password is required and should be 8 characters long.';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.grey,
              ),
              hintText: 'Enter your password',
              hintStyle: kHintTextStyle,
            ),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            obscureText: true,
            validator: (String pass) {
              if (pass != password) {
                print(pass);
                print(password);
                return 'Password did not matched.';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.grey,
              ),
              hintText: 're-enter your password',
              hintStyle: kHintTextStyle,
            ),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            onFieldSubmitted: (val) {
              _submitForm();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            //margin: EdgeInsets.symmetric(horizontal:10),
            //padding: EdgeInsets.only(top: 15.0),
            //width: 50,
            height: 50,
            child: RaisedButton(
              focusColor: Colors.black,
              elevation: 5.0,
              onPressed: () async {
                setState(() {
                  isLoading = !isLoading;
                });
                if (_formKey.currentState.validate()) {
                  currentUser.name = userName;
                  currentUser.email = email;
                  currentUser.password = password;

                  currentUser = await AuthService()
                      .registerWithEmailAndPassword(currentUser);
                  if (currentUser != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactDetails(currentUser)));
                  }
                }
                setState(() {
                  isLoading = !isLoading;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Color.fromRGBO(26, 65, 96, 1),
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          );
  }

  void _submitForm() {
    _formKey.currentState.save();

    if (!_formKey.currentState.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        backgroundColor: Color.fromRGBO(
          26,
          65,
          96,
          1,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: ListView(
            //padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildFullNamelTF(),
              SizedBox(height: 10),
              _buildEmailTF(),
              SizedBox(height: 10),
              _buildPasswordTF(),
              SizedBox(height: 10),
              _buildConfirmTF(),
              SizedBox(
                height: 30.0,
              ),
              _buildRegisterBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
