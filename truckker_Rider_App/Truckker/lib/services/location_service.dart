import 'package:Truckker/objects/user_location.dart';
import 'package:location/location.dart';


class LocationService {
  UserLocation _currentLocation;

  var location = Location();
  bool permissionGranted = false;
  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
         userLocation.latitude,
         userLocation.longitude,
      );
      permissionGranted = true;
    } catch (e) {
      
      print('Could not get the error message : $e');
    }

    return _currentLocation;
  }
}
