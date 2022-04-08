import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/photos_pages/registration_book_photo.dart';

 
class DrivingLisense extends StatefulWidget {
  Driver currentDriver;
  DrivingLisense(this.currentDriver);


  @override
  _DrivingLisenseState createState() => _DrivingLisenseState();
}

class _DrivingLisenseState extends State<DrivingLisense> {
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
                'Take a photo of your Driving License Front Side.',
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
                'Please make sure we can easily read all the details.',
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
                child: _image == null ? Image.asset(
                  'assets/driving_license.jpg',
                  fit: BoxFit.cover,
                ): Image.file(_image, fit: BoxFit.cover,),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                child: FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: getImage,
                    child: Icon(Icons.camera_alt)),
                alignment: Alignment.bottomLeft,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: "btn1",
        // child: Icon(Icons.camera_alt,color: Theme.of(context).primaryColor),
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          widget.currentDriver.drivingLiscenceUri="hello world";
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationBookPicture(widget.currentDriver)),
          );
        },
      ),
    );
  }
}
