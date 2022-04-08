import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/photos_pages/user_profile.dart';
//import 'package:image_picker_modern/image_picker_modern.dart';

class CnicBackSide extends StatefulWidget {
  Driver currentDriver;

  CnicBackSide(this.currentDriver);

  @override
  _CnicBackSideState createState() => _CnicBackSideState();
}

class _CnicBackSideState extends State<CnicBackSide> {
  ///File _image;
  File _image;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.arrow_back),
                  RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Help',
                      style: TextStyle(fontSize: 14.69, letterSpacing: 0.25),
                    ),
                    color: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Take a photo of your CNIC Back Side',
                style: TextStyle(
                    //color: Theme.of(context).primaryColor,
                    color: Colors.black,
                    letterSpacing: 0.25,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Please make sure we can easily read all the details',
                style: TextStyle(
                    //color: Theme.of(context).primaryColor,
                    color: Colors.black,
                    letterSpacing: 0.25,
                    fontSize: 15.68,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 300,
                color: Colors.grey,
                child: _image == null
                    ? Image.asset(
                        'assets/cnic_back_side.jpg',
                        fit: BoxFit.cover,
                      )
                    : Image.file(_image, fit: BoxFit.cover),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                child: FloatingActionButton(
                  heroTag: "btn7",
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: getImage,
                  child: Icon(
                    Icons.camera_alt,
                  ),
                ),
                alignment: Alignment.bottomLeft,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn8",
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (_image != null) {
            widget.currentDriver.cnicBacktUri = 'Get From Please';
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DriverProfilePic(widget.currentDriver)));
          } else {
            _showDialog();
          }
        },
        child: Icon(
          Icons.arrow_forward,
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Please First Capture Image To Go Further.",
          ),
          content: new Text("It will save from errors.",
              style: TextStyle(
                  color: Colors.grey[500], fontWeight: FontWeight.w600)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "OK",
              ),
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
