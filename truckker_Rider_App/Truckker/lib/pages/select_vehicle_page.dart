import 'package:Truckker/locator.dart';
import 'package:Truckker/models/Shipment_model.dart';
import 'package:Truckker/models/home_page_model.dart';
import 'package:Truckker/models/vehicle_model.dart';
import 'package:Truckker/pages/base_page.dart';
import 'package:Truckker/pages/single_shipment_detail_page.dart';
import 'package:flutter/material.dart';

class SelectVehicle extends StatefulWidget {
  Shipment currentShipment;

  SelectVehicle(this.currentShipment);

  @override
  _SelectVehicleState createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  //HomePageModel homePageModel = locator<HomePageModel>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 1.5;
    return Scaffold(
      body:
//      BasePage<HomePageModel>(
//        onModelReady: (model){
//          print(model.estimatedCost);
//        },
//        builder: (context, model, child) =>
          Container(
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
              'Please Choose From The Following Packages How Would You Like To Shift.',
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
                            leading: ClipOval(
                              child: Image.asset(
                                'assets/suzuki.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: new Text(
                              'Suzuki pickup',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  'estimated fare:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.68,
                                      color: Colors.white),
                                ),
                                new Text(
                                  '${widget.currentShipment.price + (widget.currentShipment.totalDistance/1000).round()*70} Rs',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.redAccent),
                                ),
                              ],
                            ),
                            onTap: () {
                              widget.currentShipment.packageType = "suzuki";
                              widget.currentShipment.price=widget.currentShipment.price+(widget.currentShipment.totalDistance/1000).round()*70 ;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleShipmetDetail(
                                      widget.currentShipment),
                                ),
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
                            leading: ClipOval(
                              child: Image.asset(
                                'assets/loaderRikshaw.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: new Text(
                              'Loader Rikshaw',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  'estimated fare :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.68,
                                      color: Colors.white),
                                ),
                                new Text(
                                  '${widget.currentShipment.price + (widget.currentShipment.totalDistance/1000).round()*50} Rs',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.redAccent),
                                ),
                              ],
                            ),
                            onTap: () {
                              widget.currentShipment.packageType = "loaderRikshaw";
                              widget.currentShipment.price=widget.currentShipment.price+(widget.currentShipment.totalDistance/1000).round()*50 ;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleShipmetDetail(
                                      widget.currentShipment),
                                ),
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
                            leading: ClipOval(
                              child: Image.asset(
                                'assets/truck.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: new Text(
                              'Truck',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  'estimated fare:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.68,
                                      color: Colors.white),
                                ),
                                new Text(
                                  '${widget.currentShipment.price + (widget.currentShipment.totalDistance/1000).round()*100} Rs',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.redAccent),
                                ),
                              ],
                            ),
                            onTap: () {
                              widget.currentShipment.packageType = "truck";
                              widget.currentShipment.price=widget.currentShipment.price+ (widget.currentShipment.totalDistance/1000).round()*100;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleShipmetDetail(
                                      widget.currentShipment),
                                ),
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
//      )
    );
  }
}
