import 'package:Truckker/models/FireDatabaseUser.dart';
import 'package:Truckker/pages/phone_auth_page.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  final User user;
  ContactDetails(this.user);
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  String userPhoneNumber;
  Color buttonColor = Colors.grey[700];

  double cursorRadius = 4.0;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final double containerWidth = deviceWidth - targetPadding * 2;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey[50],
        margin: EdgeInsets.all(targetPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              //iconSize: 20,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 70,
            ),
            Text(
              'Enter your mobile number',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans',
                  color: Colors.black),
            ),
            SizedBox(height: 70),
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
            SizedBox(height: 50),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                      "By continuing you may receive an\nSMS for verification.Message and\ndata rates may apply.", style: TextStyle( fontFamily: 'OpenSans',),),
                  SizedBox(width: 60),
                  CircleAvatar(
                    backgroundColor: buttonColor,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: userPhoneNumber == ''
                          ? () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Please enter 9 digit\nnumber to continue.', style: TextStyle( fontFamily: 'OpenSans',)),
                                    actions: <Widget>[
                                      FlatButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          : () {
                        userPhoneNumber='+92'+userPhoneNumber;
                        widget.user.phone=userPhoneNumber;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        phoneAuthPage(widget.user),),
                              );
                            },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
