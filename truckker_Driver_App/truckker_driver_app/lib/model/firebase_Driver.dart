

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String name = '';
  String id = '';
  String phone = '';
  List<dynamic> shipments = new List<dynamic>();
  String review = '';
  String location = "";
  String currentVehicle = '';
  String drivingLiscenceUri = '';
  String vehicleRegistrationBookUri = '';
  String fcmDeviceId = '';
  String cnicFrontUri = '';
  String cnicBacktUri = '';
  String profilePictUri = '';
  File cnicFrontPicture;
  File cnicBackPicture;
  File drivingLiscencePicture;
  File profilePicture;
  File vehicleRegistrationBookPicture;

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'phone': phone,
      'shipments': shipments,
      'review': review,
      'location': location,
      'currentVehicle': currentVehicle,
      'drivingLiscenceUri': drivingLiscenceUri,
      'vehicleRegistrationBookUri': vehicleRegistrationBookUri,
      'fcmDeviceId': fcmDeviceId,
      'cnicFrontUri': cnicFrontUri,
      'cnicBacktUri': cnicBacktUri,
      'profilePictUri': profilePictUri,
    };
  }

  void fromMap(DocumentSnapshot doc) {
    this.name = doc.data['name'] ?? '';
    this.id = doc.data['id'];
    this.phone = doc.data['phone'] ?? '';
    if (doc.data['shipments'] != null)
      this.shipments = List.castFrom(doc.data['shipments'] ?? '');
    else{
      this.shipments=new List();
    }
    this.review = doc.data['review'];
    this.location = doc.data['location'] ?? '';
    this.currentVehicle = doc.data['currentVehicle'] ?? "";
    this.drivingLiscenceUri = doc.data['drivingLiscenceUri'] ?? '';
    this.vehicleRegistrationBookUri =
        doc.data['vehicleRegistrationBookUri'] ?? '';
    this.fcmDeviceId = doc.data['fcmDeviceId'] ?? '';
    this.cnicFrontUri = doc.data['cnicFrontUri'] ?? '';
    this.cnicBacktUri = doc.data['cnicBacktUri'] ?? '';
    this.profilePictUri = doc.data['profilePictUri'] ?? '';
  }

  Driver(
      {this.name,
        this.id,
        this.phone,
        this.shipments,
        this.review,
        this.location,
        this.currentVehicle,
        this.drivingLiscenceUri,
        this.vehicleRegistrationBookUri,
        this.fcmDeviceId,
        this.cnicFrontUri,
        this.cnicBacktUri,
        this.profilePictUri});
}



class User{
  String name='';
  String id='';
  String email='';
  String phone='';
  List<dynamic> shipments=new List<dynamic>();
  String review='';
  String location="";
  String fcmDeviceId='';




  Map<String, dynamic>  toMap() {
    return {
      'name': name,
      'id': id,
      'phone': phone,
      'shipments': shipments,
      'review': review,
      'location': location,
      'email': email,
      'fcmDeviceId': fcmDeviceId,
    };
  }

  User({this.name, this.id, this.email, this.phone, this.shipments, this.review,
    this.location, this.fcmDeviceId});

  void  fromMap(DocumentSnapshot doc) {
    this.name = doc.data['name'] ?? '';
    this.id = doc.data['id'];
    this.phone = doc.data['phone'] ?? '';
    this.email = doc.data['email'] ?? '';
    if (doc.data['shipments'] != null)
      this.shipments = List.castFrom(doc.data['shipments'] ?? '');
    else{
      this.shipments=new List();
    }
    this.review = doc.data['review'];
    this.location = doc.data['location'] ?? '';
  }


}

