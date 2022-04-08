import 'dart:async';

import 'package:Truckker/models/Shipment_model.dart';
import 'package:Truckker/models/location_model.dart';
import 'package:Truckker/objects/user_location.dart';
import 'package:Truckker/pages/base_page.dart';
import 'package:Truckker/pages/bottom_navigation_bar.dart';
import 'package:Truckker/pages/select_vehicle_page.dart';
import 'package:Truckker/pages/vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDetails extends StatefulWidget {
  Shipment currentShipment;

  LocationDetails(this.currentShipment);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  String pickupLocation = '';
  String dropOffLocation = '';

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(31.5204, 74.3587);

  //List<Marker> allMarkers = [];
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  //Last map Position
  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onAddMarkerButtonPressed(LatLng markerPosition) {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(markerPosition.toString()),
        position: markerPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

//  Future _addMarkerLongPressed(LatLng latlang) async {
//    setState(() {
//      final MarkerId markerId = MarkerId("RANDOM_ID");
//      Marker marker = Marker(
//        markerId: markerId,
//        draggable: true,
//        position: latlang, //With this parameter you automatically obtain latitude and longitude
//        infoWindow: InfoWindow(
//          title: "Marker here",
//          snippet: 'This looks good',
//        ),
//        icon: BitmapDescriptor.defaultMarker,
//      );
//
//      _markers[markerId] = marker;
//    });
//
//    //This is optional, it will zoom when the marker has been created
//    GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newLatLngZoom(latlang, 17.0));
//  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height - 200;

    return Scaffold(
      body: BasePage<LocationModel>(
        onModelReady: (model) {
          // model.getUserLocation();
          //print(model.currentLocation.latitude);
          //double lat = model.currentLocation.latitude;
          //double lng = model.currentLocation.longitude;
          //_kGooglePlex = CameraPosition(
          //target: LatLng(lat, lng),
          // zoom: 14.4746,
          //);
        },
        builder: (context, model, child) => Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey[50],
              ),
              _buildBackArrow(),
              _buildLocationFeilds(model),
              // _buildGoogleMaps(deviceHeight),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: deviceHeight,
                  //width: double.infinity,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    mapType: _currentMapType,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    onLongPress: (latlang) {
                      print(latlang.latitude);
                      print(latlang.longitude);

//                      _addMarkerLongPressed(latlang); //we will call this function when pressed on the map
                    },
                    onCameraMove: _onCameraMove,
                  ),
                ),
              ),
              _buildDoneButton(width / 2, widget.currentShipment.price),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPickupLocationTextFeild(model) {
    UserLocation location;
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_searching,
          color: Colors.grey,
        ),
        SizedBox(width: 5),
        Container(
          height: 35,
          width: 300,
          child: new TextField(
            onChanged: (String val) {
              setState(() {
                pickupLocation = val;
              });
            },
            onSubmitted: (String pickUpLocation) async {
              location = await model.getCoordinates(pickUpLocation);
              LatLng markerPosition =
                  new LatLng(location.latitude, location.longitude);
              _onAddMarkerButtonPressed(markerPosition);
              model.startingPosition = location;
              widget.currentShipment.pickUpLocation=markerPosition.latitude.toString()+','+markerPosition.longitude.toString();
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 5.0, bottom: 5, left: 10),
              hintText: "pickup location",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.amber,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropOffTextFeild(model) {
    UserLocation location;
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: Colors.grey,
        ),
        SizedBox(width: 5),
        Container(
          height: 35,
          width: 300,
          child: new TextField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 5.0, bottom: 5, left: 10),
              hintText: "dropoff location",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  //color: Colors.amber,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onChanged: (String val) {
              setState(() {
                dropOffLocation = val;
              });
            },
            onSubmitted: (String dropLocation) async {
              location = await model.getCoordinates(dropLocation);
              LatLng markerPosition =
                  new LatLng(location.latitude, location.longitude);
              _onAddMarkerButtonPressed(markerPosition);
              model.endingPosition = location;
              widget.currentShipment.dropLocation=markerPosition.latitude.toString()+','+markerPosition.longitude.toString();
              widget.currentShipment.totalDistance=await model.calculateDistance();
              Map<PolylineId, Polyline>  polylines=await model.createPolylines();
              setState((){
                _polylines=Set<Polyline>.of(polylines.values);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBackArrow() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 50,
      width: 50,
      child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  Widget _buildLocationFeilds(model) {
    return Positioned(
      top: 60,
      left: 20,
      child: Container(
        height: 150,
        padding: EdgeInsets.all(20),
        //width: double.infinity,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildPickupLocationTextFeild(model),
            SizedBox(height: 10),
            _buildDropOffTextFeild(model),
          ],
        ),
      ),
    );
  }

  Widget _buildDoneButton(double width, int initialRate) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 50.0,
        width: width,
        child: RaisedButton(
          child: Text(
            'DONE',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectVehicle(widget.currentShipment)),
            );
          },
        ),
      ),
    );
  }

/*Widget _buildGoogleMaps(double deviceHeight) {
    allMarkers.add(
      Marker(
          markerId: MarkerId('myMarker'),
          draggable: false,
          onTap: () {
            print('marker tapped');
          },
          position: LatLng(31.5204, 74.3587)),
    );
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: deviceHeight,
        //width: double.infinity,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);

          },
          markers: allMarkers,
        ),
      ),
    );
  }*/
}
