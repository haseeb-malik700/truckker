
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckker_driver_app/model/firebaseShipment.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';

class DatabaseService {
  final String uid;
  String otherUid;
  String shipmentId;


  // collection reference
  final CollectionReference userCollection =
  Firestore.instance.collection('users');
  final CollectionReference driverCollection =
  Firestore.instance.collection('Drivers');
  final CollectionReference shipmentCollection =
  Firestore.instance.collection('shipments');


  DatabaseService(this.uid);

  Future<void> registerShipment(Shipment currentShipment) async {
    await setShipmentData(currentShipment);
    await driverCollection.document(this.uid).get().then((querySnapshot) {
      Driver currentUser = _driverDataFromSnapshot(querySnapshot);
      if(currentUser.shipments== null)
        currentUser.shipments=new List<String>();
      currentUser.shipments.add(currentShipment.shipmentId);
      driverCollection.document(uid).updateData({
        'shipments': currentUser.shipments
      });
    });
  }

  Future<void> updateDriverData(
      {Driver currentUser}) async {
    return await driverCollection.document(uid).setData(currentUser.toMap());
  }

  Future<void> updateShipmentData(
      Shipment currentShipment) async {
    return await shipmentCollection.document(currentShipment.shipmentId).setData(currentShipment.toMap());
  }

  // brew list from snapshot
  List<Shipment> _shipmentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _shipmentDataFromSnapshot(doc);
    }).toList();
  }

  List<Driver> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((snapshot) {
      return _driverDataFromSnapshot(snapshot);
    }).toList();
  }

  // user data from snapshots
  Driver _driverDataFromSnapshot(DocumentSnapshot snapshot) {
    Driver newUser=Driver();
    newUser.fromMap(snapshot);
    return newUser;
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    User newUser=User();
    newUser.fromMap(snapshot);
    return newUser;
  }

  Shipment _shipmentDataFromSnapshot(DocumentSnapshot doc) {
    Shipment currentShipment=Shipment();
    currentShipment.fromMap(doc);
    return currentShipment;
  }



  Stream<Shipment> getParticularShipment(String shipmentId) {
    this.shipmentId = shipmentId;
    return _shipment;
  }

  Stream<User> getParticularUser(String userId) {
    this.otherUid = userId;
    return _currentUserData;
  }


  Future setShipmentData(Shipment currentShipment) async {
    return await shipmentCollection
        .document(currentShipment.shipmentId)
        .setData(currentShipment.toMap());
  }

  Stream<Shipment> get _shipment {
    return shipmentCollection
        .document(shipmentId)
        .snapshots()
        .map(_shipmentDataFromSnapshot);
  }


  Stream<User> get _currentUserData {
    return userCollection.document(otherUid).snapshots().map(_userDataFromSnapshot);
  }


  Stream<Driver> get currentDriverData {
    return driverCollection.document(uid).snapshots().map(_driverDataFromSnapshot);
  }

  Stream<List<Shipment>> get shipments {
    return shipmentCollection.snapshots().map(_shipmentListFromSnapshot);
  }


  Stream<List<Shipment>> get currentDriverShipments {
    return shipmentCollection
        .where("shipperId", isEqualTo: uid)
        .snapshots()
        .map(_shipmentListFromSnapshot);
  }

  Stream<List<Driver>> get drivers {
    return driverCollection.snapshots().map(_userListFromSnapshot);
  }


}
