import 'package:Truckker/models/FireDatabaseUser.dart';
import 'package:Truckker/models/Shipment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  String otherUid;
  String shipmentId;

  DatabaseService(this.uid);

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  // collection reference
  final CollectionReference driverCollection =
      Firestore.instance.collection('Drivers');
  final CollectionReference shipmentCollection =
      Firestore.instance.collection('shipments');

  Future<void> registerShipmentToUserList(Shipment currentShipment) async {
    await setShipmentData(currentShipment);
    await userCollection.document(this.uid).get().then((querySnapshot) {
      User currentUser = _userDataFromSnapshot(querySnapshot);
      if(currentUser.shipments== null)
        currentUser.shipments=new List<String>();
      currentUser.shipments.add(currentShipment.shipmentId);
        userCollection.document(uid).updateData({
          'shipments': currentUser.shipments
        });
    });
  }

  Future<void> setUserData(
      User user) async {
    return await userCollection.document(uid).setData(user.toMap());
  }

  Future<void> updateShipmentData(
      Shipment shipment) async {
    return await shipmentCollection.document(shipment.shipmentId).setData(shipment.toMap());
  }

  // brew list from snapshot
  List<Shipment> _shipmentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _shipmentDataFromSnapshot(doc);
    }).toList();
  }

  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((snapshot) {
      return _userDataFromSnapshot(snapshot);
    }).toList();
  }

  // user data from snapshots
  Driver _driverDataFromSnapshot(DocumentSnapshot snapshot) {
   Driver myDriver=Driver();
   myDriver.fromMap(snapshot);
   return myDriver;
  }


  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    User newUser=User();
    newUser.fromMap(snapshot);
    return newUser;
  }

  Shipment _shipmentDataFromSnapshot(DocumentSnapshot doc) {
    Shipment current=Shipment();
    current.fromMap(doc);
    return current;
  }

  // get brews stream
  Stream<List<Shipment>> get shipments {
    return shipmentCollection.snapshots().map(_shipmentListFromSnapshot);
  }

  Stream<List<Shipment>> get userShipments {
    return shipmentCollection
        .where("customerId", isEqualTo: uid)
        .snapshots()
        .map(_shipmentListFromSnapshot);
  }

  Stream<List<User>> get users {
    return shipmentCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<Shipment> getParticularShipment(String shipmentId) {
    this.shipmentId = shipmentId;
    return _shipment;
  }

  Stream<Driver> getParticularDriver(String userId) {
    this.otherUid = userId;
    return userData;
  }

  Stream<Shipment> get _shipment {
    return shipmentCollection
        .document(shipmentId)
        .snapshots()
        .map(_shipmentDataFromSnapshot);
  }

  Stream<Driver> get userData {
    return driverCollection
        .document(otherUid)
        .snapshots()
        .map(_driverDataFromSnapshot);
  }

  Stream<User> get currentUserData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future setShipmentData(Shipment currentShipment) async {
    return await shipmentCollection
        .document(currentShipment.shipmentId)
        .setData(currentShipment.toMap());
  }
}
