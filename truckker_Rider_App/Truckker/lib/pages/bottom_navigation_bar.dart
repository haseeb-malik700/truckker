import 'package:Truckker/models/Shipment_model.dart';
import 'package:Truckker/pages/home_page.dart';
import 'package:Truckker/pages/live_tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  final Shipment currentShipment;
  BottomNavBar(this.currentShipment);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  //Create All Pages 

 // final DriverInformation _driverInformation = new DriverInformation();
  //final VehiclePage _vehiclePage = new VehiclePage();
  //final ActiveShipments _activeShipments = new ActiveShipments();
  Widget showPage;

  Widget _pageChooser(int page){
    switch(page){
      case 0:
      return LiveTrackingPage(widget.currentShipment);
      case 1: 
      return HomePage(widget.currentShipment.customerId);
    } 

  }

  @override
  void initState() {
    // TODO: implement initState
    showPage=_pageChooser(0);
    super.initState();
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 40.0,
          items: <Widget>[
            //Icon(Icons.directions_car, size: 35),
            //Icon(Icons.list, size: 35),
            Icon(Icons.location_on, size: 35),
            Icon(Icons.home, size: 35),            
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          animationCurve: Curves.bounceInOut,
          animationDuration: Duration(milliseconds: 200),
          onTap: (int tappedIndex) {
            setState(() {
              showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: showPage
          ),
        ));
  }
}