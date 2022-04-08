import 'package:Truckker/models/auth_model.dart';
import 'package:Truckker/models/driver_page_model.dart';
import 'package:Truckker/models/live_location_model.dart';
import 'package:Truckker/models/location_model.dart';
import 'package:Truckker/models/user_model.dart';
import 'package:Truckker/models/vehicle_model.dart';
import 'package:Truckker/services/auth_service.dart';
import 'package:Truckker/services/location_service.dart';
import 'package:Truckker/services/userData_service.dart';
import 'package:get_it/get_it.dart';

import 'models/home_page_model.dart';

GetIt locator = GetIt.instance;

setupLocator(){ 
  locator.registerLazySingleton(() => Auth());
  locator.registerFactory(() =>UserModel());
  locator.registerFactory(() =>HomePageModel());
  locator.registerFactory(() => LocationModel());
  locator.registerFactory(() => DriverModel());
  locator.registerFactory(() => VehicleModel());
  locator.registerFactory(() => LiveLocationModel());
  locator.registerFactory(() => AuthModel());
  locator.registerLazySingleton(() => LocationService() );
  locator.registerLazySingleton(() => UserData() );
}