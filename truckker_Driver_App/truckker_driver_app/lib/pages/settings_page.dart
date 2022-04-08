
//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:truckker_driver_app/model/user_model.dart';
import 'package:truckker_driver_app/pages/base_page.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final Map<String,dynamic> _formData={
    'name':null,
    'email':null,
    'phoneNumber':null,
    'changePassword': null,
    'confirmPassword': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'FullName'),

      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildProfile() {
    return Container(
              width: 50,
              height: 200,
            
              child: Container(
                height: 50,
                width: 50,
                child: ClipOval(
                  child:Image.asset('assets/profilePic.jpg', fit: BoxFit.cover,),
                ),
              )
    );      
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      onSaved: (String value) {
        _formData['email']= value;
      },
    );
  }

  Widget _buildPhoneNoTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Phone Number'),
      onSaved: (String value) {
          _formData['phoneNumber'] = value;
      },
    );
  }

  Widget _buildCpasswordTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Change Password'),
      onSaved: (String value) {
          _formData['changePassword'] = value;
      },
    );
  }

    Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Confirm Password'),
      onSaved: (String value) {
          _formData['confirmPassword'] = value;
      },
    );
  }

  void _submitForm() {
    _formKey.currentState.save();
  }


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return Scaffold(
      appBar: AppBar(
      title: Text('Settings'),
      centerTitle: true,
      ),
      body: BasePage<UserModel>(onModelReady:(model) {

      },
       builder: (context, model, child) => Container(
      
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10 ),
          children: <Widget>[
            /*
            ),*/
            _buildProfile(),
            _buildNameTextField(),
            _buildEmailTextField(),
            _buildPhoneNoTextField(),
            _buildCpasswordTextField(),
            _buildConfirmPasswordTextField(),
            SizedBox(
              height: 20.0, 
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal:100),
              child: RaisedButton(
                child: Text('Save Settings'),
                textColor: Colors.white,
                onPressed: _submitForm,
                color: Colors.redAccent,
              ),
            )
            // GestureDetector(
            //   onTap: _submitForm,
            //   child: Container(
            //     color: Colors.green,
            //     padding: EdgeInsets.all(5.0),
            //     child: Text('My Button'),
            //   ),
            // )
          ],
        ),
      ),
       )
       )
    );
  }
}