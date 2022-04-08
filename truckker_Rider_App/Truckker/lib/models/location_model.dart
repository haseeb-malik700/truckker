import 'package:Truckker/models/base_model.dart';
import 'package:Truckker/objects/user_location.dart';
import 'package:Truckker/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../locator.dart';


class LocationModel extends BaseModel {
  final LocationService _userLocation = locator<LocationService>();

  UserLocation currentLocation = UserLocation(0.0, 0.0);

  Future<void> getUserLocation() async {
    currentLocation = await _userLocation.getLocation();
  }

//If user enables location then marker on map will be updated according to current location , and
//picupLoc feild will be updated with the address returned by this function. 
  Future<String> getPickupLocation() async {
    final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.addressLine;
  }
 
 //If user Does not tap on currentLoc icon , then this will give us coordinates and location on map 
 //will be updates accodingly,
  Future<UserLocation> getCoordinates(String address) async {
    Coordinates userCoordinates ;
    var addresses = await Geocoder.local.findAddressesFromQuery(address);
    var first = addresses.first;
    userCoordinates = first.coordinates;
    UserLocation loc = new UserLocation(userCoordinates.latitude,userCoordinates.longitude);
    return loc;
  }

   UserLocation startingPosition ;
   UserLocation endingPosition ;

   double distanceInKiloMeters;

   Future<double> calculateDistance() async {
     double distanceInMeters = await new Geolocator().distanceBetween(startingPosition.latitude, startingPosition.longitude, endingPosition.latitude, endingPosition.longitude);
     distanceInKiloMeters = distanceInMeters;
     return distanceInKiloMeters;
   }


  // Map storing polylines created by connecting
  // two points


  Future<Map<PolylineId, Polyline>> createPolylines() async {
    // Object for PolylinePoints
    PolylinePoints polylinePoints;

// List of coordinates to join
    List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting
// two points
    Map<PolylineId, Polyline> polylines = {};
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBzOaxKJY6wF03dPsLmPkbFQ-A7glCLQiM", // Google Maps API Key
      PointLatLng(startingPosition.latitude, startingPosition.longitude),
      PointLatLng(endingPosition.latitude, endingPosition.longitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
    return polylines;
  }





}
