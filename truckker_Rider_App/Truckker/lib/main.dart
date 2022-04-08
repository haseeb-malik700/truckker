import 'package:Truckker/locator.dart';
import 'package:Truckker/objects/LoggedInUserInfo.dart';
import 'package:Truckker/pages/add_new_shipment.dart';
import 'package:Truckker/pages/bottom_navigation_bar.dart';
import 'package:Truckker/pages/contact_detail_page.dart';
import 'package:Truckker/pages/current_shippments.dart';
import 'package:Truckker/pages/driver_info_page.dart';
import 'package:Truckker/pages/home_page.dart';
import 'package:Truckker/pages/live_tracking_page.dart';
import 'package:Truckker/pages/location_Details.dart';
import 'package:Truckker/pages/login_page_animation.dart';
import 'package:Truckker/pages/map.dart';
import 'package:Truckker/pages/phone_auth_page.dart';
import 'package:Truckker/pages/settings_page.dart';
import 'package:Truckker/pages/sign_UP.dart';
import 'package:Truckker/pages/single_shipment_detail_page.dart';
import 'package:Truckker/pages/splash_screen.dart';
import 'package:Truckker/pages/splash_screen_with_animation.dart';
import 'package:Truckker/pages/starting_page.dart';
import 'package:Truckker/pages/user_deliveries_page.dart';
import 'package:Truckker/pages/vehicle_page.dart';
import 'package:Truckker/services/auth_service.dart';
import 'package:Truckker/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Truckker/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login UI',
        theme: ThemeData(
          cursorColor: Color.fromRGBO(26, 65, 96, 1),
          primaryColor: Color.fromRGBO(26, 65, 96, 1),
        ),
        home: SplashScreen());
  }
}
