import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truckker_driver_app/Animations/fadeAnimation.dart';
import 'package:truckker_driver_app/model/auth_model.dart';
import 'package:truckker_driver_app/pages/base_page.dart';
import 'package:truckker_driver_app/pages/homePage.dart';
import 'package:truckker_driver_app/view_states.dart';

class LoginAnimation extends StatefulWidget {
  @override
  _LoginAnimationState createState() => _LoginAnimationState();
}

class _LoginAnimationState extends State<LoginAnimation> {
  String otpCode = '';
  Color buttonColor = Colors.grey[700];
  String userPhoneNumber = '';
  String verificationCode = '';
  String isInfoOk = '';

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final double containerWidth = deviceWidth - targetPadding * 2;

    return Scaffold(
      // backgroundColor: Color.fromRGBO(26, 65, 96, 1),
      backgroundColor: Colors.grey[50],
      body: Container(
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
            FadeAnimation(1.5, _buildUsernameTf(containerWidth, deviceWidth)),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(1.5, _buildPasswordTf(containerWidth, deviceWidth)),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeAnimation(
                  1.8,
                  Center(child: _builButton(userPhoneNumber, otpCode)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _builButton(String id, String password) {
    return BasePage<AuthModel>(
        onModelReady: (model) {},
        builder: (context, model, child) => model.state == ViewState.Busy
            ? CircularProgressIndicator()
            : FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () async {
                  _signInWithPhoneNumber(null);
                },
              ));
  }

  Widget _buildUsernameTf(double containerWidth, double deviceWidth) {
    return Column(
      children: <Widget>[
        Container(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10),

              Image(
                image: AssetImage('assets/logos/flag.jpg'),
              ),

              //SizedBox(width:5),

              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
                size: 30,
              ),

              Text(
                '+92',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'OpenSans',
                ),
              ),

              SizedBox(width: 10),

              SizedBox(
                  width: deviceWidth / 2,
                  child: new TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (String val) {
                      setState(() {
                        userPhoneNumber = val;
                        if (userPhoneNumber != null) {
                          buttonColor = Theme.of(context).primaryColor;
                        } else {
                          buttonColor = Colors.grey[700];
                        }
                      });
                    },
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "301 6206627",
                      focusColor: Color.fromRGBO(26, 65, 96, 1),
                    ),
                  )),
            ],
          ),
        ),
        RaisedButton(
          onPressed: () {
            verifyPhone('+92'+userPhoneNumber);
          },
          child: Text("Verify Number"),
        )
      ],
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
              otpCode = val;
            });
          },
          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            hintText: "One Time Password",
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

  Future<void> verifyPhone(String userPhoneNumber) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      _signInWithPhoneNumber(authResult);
      print('phone number Verifid');
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationCode = verId;

    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String varId) {
      this.verificationCode = varId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: userPhoneNumber,
        timeout: const Duration(seconds: 50),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  void _signInWithPhoneNumber(AuthCredential credential) async {
    if (credential == null)
      credential = PhoneAuthProvider.getCredential(
          verificationId: verificationCode, smsCode: otpCode);

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      if (value != null) {
        gotoHome(value.user.uid);
      }
    });
  }

  void gotoHome(String userId) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage(userId)));
  }


}
