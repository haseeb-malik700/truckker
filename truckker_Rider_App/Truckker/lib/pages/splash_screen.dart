import 'dart:async';

import 'package:Truckker/pages/home_page.dart';
import 'package:Truckker/pages/login_page.dart';
import 'package:Truckker/pages/splash_screen_with_animation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreeAnimation()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double w = MediaQuery.of(context).size.width / 1.5;
    final double padding = width - w;

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(26, 65, 96, 1)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/logos/image.jpg',
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding - 40),
              child: LinearProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.lightBlue[200]),
                backgroundColor: Colors.white,
              ),
            )
          ],
        ),
      ],
    ));
  }
}
