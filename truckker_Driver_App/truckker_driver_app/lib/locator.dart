import 'package:get_it/get_it.dart';
import 'package:truckker_driver_app/model/auth_model.dart';
import 'package:truckker_driver_app/model/user_model.dart';
import 'package:truckker_driver_app/services/auth_service.dart';

GetIt locator = GetIt.instance;

setupLocator(){ 
  locator.registerLazySingleton(() => Auth());
  locator.registerFactory(() =>AuthModel());
  locator.registerFactory(() =>UserModel());
}