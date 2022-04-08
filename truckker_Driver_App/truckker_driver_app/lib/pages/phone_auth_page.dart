import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/login_page_animation.dart';
import 'package:truckker_driver_app/pages/sigup.dart';
import 'package:truckker_driver_app/services/firebase_database.dart';

class phoneAuthPage extends StatefulWidget {
  final Driver driver;

  phoneAuthPage(this.driver);

  @override
  _phoneAuthPageState createState() => _phoneAuthPageState();
}

class _phoneAuthPageState extends State<phoneAuthPage> {
  String enteredCode = '';

  String verificationId;

  bool isInfoOk = false;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final double containerWidth = targetWidth - targetPadding * 2;
    final double dwidth = containerWidth - 60;
    final double width = dwidth / 6;
    verifyPhone(widget.driver.phone);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone number verification',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey[50],
        margin: EdgeInsets.all(targetPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            _buildNumber(),
            SizedBox(height: 50.0),
            _buildCodeInputFeilds(width),
            SizedBox(height: 60.0),
            _buildNotGetCodeLabel('I haven`t received a code'),
            Row(
              children: <Widget>[
                _buildNotGetCodeLabel('Edit my mobile number'),
                SizedBox(width: dwidth / 2 - 30),
                _buildRaisedButton()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumber() {
    return Row(
      children: <Widget>[
        SizedBox(width: 5.0),
        Text(
          'Please enter the 6-digit code sent\nto you at ${widget.driver.phone}.',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontFamily: 'OpenSans',
              fontSize: 20),
        )
      ],
    );
  }

  Widget _buildCodeInputFeilds(double width) {
    return Row(
      children: <Widget>[
        _buildInputContainer(width),
        SizedBox(width: 5.0),
        _buildInputContainer(width),
        SizedBox(width: 5.0),
        _buildInputContainer(width),
        SizedBox(width: 5.0),
        _buildInputContainer(width),
        SizedBox(width: 5.0),
        _buildInputContainer(width),
        SizedBox(width: 5.0),
        _buildInputContainer(width),
        SizedBox(width: 5.0),
      ],
    );
  }

  Widget _buildInputContainer(double containerwidth) {
    return Container(
      height: 40,
      width: containerwidth,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.blueGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
          autofocus: true,
          textInputAction: TextInputAction.next,
          onChanged: (no) => this.setState(() {
                enteredCode += no;
              }),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          style: new TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'OpenSans',
          )),
    );
  }

  Widget _buildRaisedButton() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      onPressed: () {
        _signInWithPhoneNumber(null);
      },
    );
  }

  Widget _buildNotGetCodeLabel(String label) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginAnimation())),
      child: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildTextInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          Text(
            'Tap Next to get an SMS confirmation frm Account Kit',
            style: TextStyle(
                fontWeight: FontWeight.normal, color: Color(0XFF616161)),
          ),
          Text(
            ' powered by FaceBook. Truckker Rider uses Firebase',
            style: TextStyle(
                fontWeight: FontWeight.normal, color: Color(0XFF616161)),
          ),
          Text(
            ' technology to help you sign in,but you dont need a',
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
          ),
          Text(
            'FireBase account. Message and data rates may apply.',
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
          ),
        ],
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
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String varId) {
      this.verificationId = varId;
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
          verificationId: verificationId, smsCode: enteredCode);

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      if (value != null) {
        widget.driver.id = value.user.uid;
        isInfoOk = true;
      }
    });
    if (isInfoOk) {
      await FirebaseAuth.instance.signOut();
      await DatabaseService(widget.driver.id)
          .updateDriverData(currentUser: widget.driver);
      gotoSignUp();
    }
    isInfoOk=false;
  }

  void gotoSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp(widget.driver),
        ));
  }
}
