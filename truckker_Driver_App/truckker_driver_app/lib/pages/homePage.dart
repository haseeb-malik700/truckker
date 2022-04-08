import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:truckker_driver_app/model/firebaseShipment.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/done_shipments.dart';
import 'package:truckker_driver_app/pages/ignored_shipment_requests.dart';
import 'package:truckker_driver_app/pages/new_shipment_requests.dart';
import 'package:truckker_driver_app/pages/photos_pages/active_shipments.dart';
import 'package:truckker_driver_app/pages/settings_page.dart';
import 'package:truckker_driver_app/pages/submitted_bids.dart';
import 'package:truckker_driver_app/services/firebase_database.dart';
import 'package:truckker_driver_app/services/location_service.dart';
import 'package:truckker_driver_app/widgets/tab_header.dart';

class MyHomePage extends StatefulWidget {
  String userId;
  MyHomePage(this.userId);
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHomePage> {
  Location location =Location();
  bool isLocationAllow=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }


  @override
  Widget build(BuildContext context) {
    if(isLocationAllow) {

      return StreamBuilder<Driver>(
          stream: DatabaseService(widget.userId).currentDriverData,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            Driver driver = snapshot.data;
            return StreamBuilder<List<Shipment>>(
                stream: DatabaseService(driver.id).shipments,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<Shipment> shipments = snapshot.data;
                  return StreamBuilder<LocationData>(
                    stream:location.onLocationChanged(),
                    builder: (context, snapshot) {
                      if (snapshot.data!=null){
                        LocationData locationData=snapshot.data;
                        List<Shipment> activeShipment=shipments.where((element) {
                          if (element.shipperId==driver.id&&element.condition=='accepted')
                            return true;
                          return false;
                        }).toList();
                        activeShipment.forEach((element) async {
                          element.currentLocation=locationData.latitude.toString()+','+locationData.longitude.toString();
                          await DatabaseService(driver.id).updateShipmentData(element);
                        });
                      }
                      return DefaultTabController(
                        child: Scaffold(
                          appBar: AppBar(
                            title: Text('Truckker Driver'),
                            backgroundColor: Theme
                                .of(context)
                                .primaryColor,
                            // leading: Icon(Icons.list),
                            actions: <Widget>[
                              IconButton(
                                icon: Icon(Icons.notifications_active),
                                onPressed: () {},
                              ),

                            ],
                            bottom: TabBar(
                              indicatorColor: Colors.white,
                              // indicatorColor: Colors.transparent,
                              tabs: [
                                new Container(
                                  height: 60,
                                  child: new Tab(text: 'New'),
                                ),
                                Text('Active'),
                                Text('Done'),
                                Text('Ignore'),
                              ],
                            ),
                          ),
                          drawer: Drawer(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: <Widget>[
                                UserAccountsDrawerHeader(
                                    accountName: Text(driver.name),
                                    accountEmail: Text(driver.phone),
                                    currentAccountPicture: ClipOval(
                                      child: Image.asset(
                                        'assets/profilePic.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                                ListTile(
                                  leading: Icon(Icons.traffic),
                                  title: Text('My Account'),
                                  /*onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserDeliveries()),
                            );
                          },*/
                                ),
                                ListTile(
                                  leading: Icon(Icons.payment),
                                  title: Text('Payments'),
                                  /*onTap: () {
                            user != null
                                ? print(user.user.id)
                                : print('user object is null');
                            print(user.jwt);
                          },*/
                                ),
                                ListTile(
                                  leading: Icon(Icons.settings),
                                  title: Text('Settings'),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Settings()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          body: TabBarView(
                            children: <Widget>[
                              NewShipmentRequests(driver, shipments),
                              ActiveShipments(driver, shipments),
                              DoneShipments(driver, shipments),
                              IgnoredShipments(driver, shipments),
                            ],
                          ),
                        ),
                        length: 4,
                      );
                    }
                  );
                }
            );
          }
      );
    }
    else
      return Center(child: Text("Please Allow the Location Services"));
  }





  Future getPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          isLocationAllow=false;
        });
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        setState(() {
          isLocationAllow=false;
        });
        return;
      }
    }
    setState(() {
      isLocationAllow=true;
    });
  }

}
