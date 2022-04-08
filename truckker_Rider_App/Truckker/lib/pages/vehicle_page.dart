import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';

const double CAMERA_TILT = 0;
const double CAMERA_ZOOM = 11;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(31.5204, 74.3587);
const LatLng DEST_LOCATION = LatLng(31.4312, 74.2644);

class VehiclePage extends StatefulWidget {
  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  Set<Marker> _markers = {};
// this will hold the generated polylines
  Set<Polyline> _polylines = {};
// this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();

  static const LatLng _center = const LatLng(31.5204, 74.3587);

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION);

//For setting of Pins
    void setMapPins() {
      setState(() {
        // source pin
        _markers.add(Marker(
            markerId: MarkerId('sourcePin'),
            position: SOURCE_LOCATION,
            icon: sourceIcon));
        // destination pin
        _markers.add(Marker(
            markerId: MarkerId('destPin'),
            position: DEST_LOCATION,
            icon: destinationIcon));
      });
    }


    void onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
      setMapPins();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              child: GoogleMap(
                  myLocationEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: false,
                  markers: _markers,
                  polylines: _polylines,
                  mapType: MapType.normal,
                  initialCameraPosition: initialLocation,
                  onMapCreated: onMapCreated)),
          Positioned(
            bottom: 10,
            left: 20,
            child: RaisedButton(
              onPressed: () {
                _settingModalBottomSheet(context);
              },
              child: Text(
                'Select Vehicle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.68,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              color: Colors.redAccent,
            ),
          )
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        'assets/suzuki.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: new Text(
                      'Suzuki pickup',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    subtitle: new Text(
                      '600KG Container',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12.68),
                    ),
                    onTap: () => {}),
                new ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      'assets/loaderRikshaw.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: new Text(
                    'Loader Rikshaw',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  subtitle: new Text(
                    '200KG Container',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12.68),
                  ),
                  onTap: () => {},
                ),
                new ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      'assets/truck.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: new Text(
                    'Truck',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  subtitle: new Text(
                    '1000KG Container',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.68,
                    ),
                  ),
                  onTap: () => {
                    _showDialog(),
                  },
                ),
                ListTile(
                  trailing: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _showDialog2();
                  },
                  child: Text('Submit For Bids', style: TextStyle(fontSize:17,color:Colors.white,),),
                ))
              ],
            ),
          );
        });
  }

   void  _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("You Have Selected A Truck.", ),
          content: new Text("1000kg", style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w600)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK" ,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void  _showDialog2() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Your request has been sucessfully submitted for bidding.", ),
          content: new Text("Thankyou for using truckker", style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w600)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK" ,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}




/*
  Widget _buildDoneButton(double width) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 50.0,
        width: width,
        child: RaisedButton(
          child: Text(
            'CONFIRM',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VehiclePage()),
            );
          },
        ),
      ),
    );
  }*/
