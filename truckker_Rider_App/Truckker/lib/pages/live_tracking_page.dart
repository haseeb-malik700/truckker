import 'dart:async';

import 'package:Truckker/models/Shipment_model.dart';
import 'package:Truckker/models/live_location_model.dart';
import 'package:Truckker/pages/base_page.dart';
import 'package:Truckker/services/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTrackingPage extends StatefulWidget {
  Shipment shipment;

  LiveTrackingPage(this.shipment);

  @override
  _LiveTrackingPageState createState() => _LiveTrackingPageState();
}

class _LiveTrackingPageState extends State<LiveTrackingPage> {
  static const LatLng _center = const LatLng(31.5204, 74.3587);

  //List<Marker> allMarkers = [];
  Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;
  LatLng _lastMapPosition = _center;

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  String currentLocation = '';

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    setCordinates();
    return StreamBuilder<Shipment>(
        stream: DatabaseService(widget.shipment.customerId)
            .getParticularShipment(widget.shipment.shipmentId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: Column(
              children: <Widget>[
                Text("Please wait"),
                CircularProgressIndicator(),
              ],
            ));
          }
          setNewValues(snapshot.data);
          setCordinates();
          return Scaffold(
            body: BasePage<LiveLocationModel>(
              onModelReady: (model) {},
              builder: (context, model, child) => Container(
                  color: Color(0xFFECEFF1),
                  child: Stack(
                    children: <Widget>[
                      _buildMap(),
                      _buildCurrentLocationDetails2()
                    ],
                  )),
            ),
          );
        });
  }

  Widget _buildMap() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: _currentMapType,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
        onCameraMove: _onCameraMove,
      ),
    );
  }

  Widget _buildCurrentLocationDetails2() {
    return Positioned(
      bottom: 30.0,
      left: 10.0,
      right: 10.0,
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 25.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Current Location :  $currentLocation",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Current Status :${widget.shipment.condition}",
                  style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
            ),
            SizedBox(height: 10),
            Text(
              'TRUCKER MOVES YOU',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Text('WE KEEP YOUR VALUEABLES SAFE',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white)),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Future<void> setCordinates() async {
    Coordinates pickUp = Coordinates(
        double.parse(widget.shipment.currentLocation.split(',')[0]),
        double.parse(widget.shipment.currentLocation.split(',')[1]));
    var addresses = await Geocoder.local.findAddressesFromCoordinates(pickUp);
    var first = addresses.first;

      currentLocation = first.addressLine;

  }

  void setNewValues(Shipment data) {
    widget.shipment.currentLocation=data.currentLocation;
  }
}
