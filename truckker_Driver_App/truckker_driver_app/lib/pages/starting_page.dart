import 'package:flutter/material.dart';
import 'package:truckker_driver_app/pages/login_page_animation.dart';
import 'package:truckker_driver_app/pages/remaining_steps_page.dart';
import 'package:truckker_driver_app/pages/select_vehicle_page.dart';
import 'package:truckker_driver_app/pages/sigup.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width/2;
    final double mainContainerHeight = deviceHeight / 1.25;
    final double remainigHeight = deviceHeight - mainContainerHeight;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: mainContainerHeight,
            color: Color.fromRGBO(26, 65, 96, 1),
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/logos/image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey[50],
            padding: EdgeInsets.symmetric(vertical: 10),
            height: remainigHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: deviceWidth-30,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                       Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginAnimation(),),
                              );
                    },
                    child: Text('LOGIN'),
                    //color: Colors.white,
                  ),

                ),
                SizedBox(width:20),
                Container(
                  width: deviceWidth-30,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SelectVehicle(),),
                              );
                    },
                    child:
                        Text('REGISTER', style: TextStyle(color: Colors.white)),
                    color: Color.fromRGBO(26, 65, 96, 1),
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
