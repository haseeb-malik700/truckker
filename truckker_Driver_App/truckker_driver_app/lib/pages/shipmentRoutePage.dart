import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double CAMERA_TILT = 0;
const double CAMERA_ZOOM = 11;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(31.5204, 74.3587);
const LatLng DEST_LOCATION = LatLng(31.4312, 74.2644);

class ShipmentRoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<ShipmentRoutePage> {
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

//For polyLines
    setPolylines() async {
      List<PointLatLng> result =
          await polylinePoints?.getRouteBetweenCoordinates(
              'AIzaSyBf-T1XSrz5YPhyGYxBc2ZW0vRIAzwHzOk',
              SOURCE_LOCATION.latitude,
              SOURCE_LOCATION.longitude,
              DEST_LOCATION.latitude,
              DEST_LOCATION.longitude);
      if (result.isNotEmpty) {
        // loop through all PointLatLng points and convert them
        // to a list of LatLng, required by the Polyline
        result.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      setState(() {
        // create a Polyline instance
        // with an id, an RGB color and the list of LatLng pairs
        Polyline polyline = Polyline(
            polylineId: PolylineId('poly'),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates);

        // add the constructed polyline as a set of points
        // to the polyline set, which will eventually
        // end up showing up on the map
        _polylines.add(polyline);
      });
    }

    void onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
      setMapPins();
      //setPolylines();
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
                 // polylines: _polylines,
                  mapType: MapType.normal,
                  initialCameraPosition: initialLocation,
                  onMapCreated: onMapCreated)),
          Positioned(
            bottom: 10,
            left: 20,
            child: RaisedButton(
              onPressed: () {
               // _settingModalBottomSheet(context);
              },
              child: Text(
                'Start Ride',
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
}