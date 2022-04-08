import 'package:flutter/material.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/remaining_steps_page.dart';

class SelectVehicle extends StatefulWidget {
  @override
  _SelectVehicleState createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  Driver currentDriver=Driver();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 1.5;
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Truckker',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.68,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.bold),
                ),
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
              'Please Choose How Would You Like To Partner With Truckker.',
              style: TextStyle(
                  //color: Theme.of(context).primaryColor,
                  color: Colors.black,
                  letterSpacing: 0.25,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            Container(
                height: h,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: h / 4,
                      margin: EdgeInsets.only(top: 10),
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: ListTile(
                            title: Text(
                              'Loader Rikshaw',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 17.79,
                              ),
                            ),
                            subtitle: Text(
                              'You want to drive a open riskshaw on Truckker plaform',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              currentDriver.currentVehicle="loaderRikshaw";
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RemainingSteps(currentDriver)),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: h / 4,
                      margin: EdgeInsets.only(top: 10),
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: ListTile(
                            title: Text(
                              'Suzuki Pickup',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 17.79,
                              ),
                            ),
                            subtitle: Text(
                              'You want to drive a two door  pickup on Truckker plaform',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              currentDriver.currentVehicle="suzuki";
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RemainingSteps(currentDriver)),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: h / 4,
                      margin: EdgeInsets.only(top: 10),
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: ListTile(
                            title: Text(
                              'Truck',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 17.79,
                              ),
                            ),
                            subtitle: Text(
                              'You want to drive a two door truck on Truckker plaform',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              currentDriver.currentVehicle="truck";
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RemainingSteps(currentDriver)),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
