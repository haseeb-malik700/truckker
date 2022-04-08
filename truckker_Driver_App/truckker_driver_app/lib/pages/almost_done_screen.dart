import 'dart:async';

import 'package:flutter/material.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/contact_detail_page.dart';

class AlmostDoneScreen extends StatefulWidget {
  Driver currentDriver;
  AlmostDoneScreen(this.currentDriver);
  @override
  _AlmostDoneScreenState createState() => _AlmostDoneScreenState();
}

class _AlmostDoneScreenState extends State<AlmostDoneScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactDetails(widget.currentDriver)),
        );

      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(child:  Image.asset(
                  'assets/logos/image.jpg',
                  //fit: BoxFit.cover,
                ),),

            SizedBox(height: 20,),
           
            Text('Thanks For Being So Long With Us We Are Almost Done.',style: TextStyle(color:Colors.grey[800], fontSize: 25, letterSpacing: 0.25),),
            //Text('     We Are Almost Done     ',style: TextStyle(color:Colors.grey[800], fontSize: 25, letterSpacing: 0.25),),
            SizedBox(height: 30,),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
