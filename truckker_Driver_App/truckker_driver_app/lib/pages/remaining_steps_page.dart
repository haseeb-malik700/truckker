import 'package:flutter/material.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/driving_license_photo.dart';

class RemainingSteps extends StatefulWidget {
  Driver currentDriver;
  RemainingSteps(this.currentDriver);
  @override
  _RemainingStepsState createState() => _RemainingStepsState();
}

class _RemainingStepsState extends State<RemainingSteps> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 1.4;
    bool isSelected = false;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              'Welcome',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Remaining steps,',
              style: TextStyle(
                  fontSize: 16.68,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Here`s what you need to setup your account,',
              style: TextStyle(
                  fontSize: 15.68,
                  letterSpacing: 0.25,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            Container(
              height: h,
              child: ListView(
                children: <Widget>[
                  Container(
                   
                    height: h / 5,
                    child: Card(
                     // color: Colors.indigo[50],
                     color: Theme.of(context).primaryColor,
                      child: ListTile(
                        trailing: Icon(Icons.keyboard_arrow_right),
                        selected: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrivingLisense(widget.currentDriver),
                            ),
                          );
                        },
                        subtitle: Text(
                          'Driving License Front Side',
                          style: TextStyle(
                             color: Colors.white,
                              fontSize: 19,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600),
                        ),
                        title: Text(
                          'Recommended next step',
                          style: TextStyle(
                            color: Colors.white,
                              fontSize: 14,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:5),
                  Container(
                    height: h / 5,
                    child: Card(
                      color: Colors.grey[300],
                      child: ListTile(
                        selected: true,
                        onTap: () {
                          _showDialog();
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                        subtitle: Text(
                          'Vehicle Book Picture',
                          style: TextStyle(
                              fontSize: 19,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600),
                        ),
                        title: Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: h / 5,
                    child: Card(
                      color: Colors.grey[300],
                      child: ListTile(
                        selected: true,
                        onTap: () {
                          _showDialog();
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                        subtitle: Text(
                          'CNIC Back Side',
                          style: TextStyle(
                              fontSize: 19,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600),
                        ),
                        title: Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: h / 5,
                    child: Card(
                      color: Colors.grey[300],
                      child: ListTile(
                        selected: true,
                        onTap: () {
                          _showDialog();
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                        subtitle: Text(
                          'CNIC Front Side',
                          style: TextStyle(
                              fontSize: 19,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600),
                        ),
                        title: Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: h / 5,
                    child: Card(
                      color: Colors.grey[300],
                      child: ListTile(
                        selected: true,
                        onTap: () {
                          _showDialog();
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                        subtitle: Text(
                          'Partner photo',
                          style: TextStyle(
                              fontSize: 19,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600),
                        ),
                        title: Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

    void  _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Please Go With Recommended Next Step.", ),
          content: new Text("It will save alot of time.", style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w600)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK" ,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
