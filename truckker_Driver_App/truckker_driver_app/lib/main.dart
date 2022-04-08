import 'package:flutter/material.dart';
import 'package:truckker_driver_app/locator.dart';
import 'package:truckker_driver_app/pages/homePage.dart';
import 'package:truckker_driver_app/pages/sigup.dart';

import 'pages/splash_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        cursorColor: Color.fromRGBO(26, 65, 96, 1), 
        primaryColor :  Color.fromRGBO(26, 65, 96, 1),),
      home: SplashScreen(),
    );
  }
}
 