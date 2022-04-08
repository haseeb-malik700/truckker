import 'package:cloud_firestore/cloud_firestore.dart';

class Shipment {
  String condition;
  String shipmentId;
  String shipperId;
  String customerId;
  int price;
  String discount;
  String packageType;
  String deliveryDate;
  String pickUpLocation;
  String shipmentPackage;
  double totalDistance;
  String dropLocation;
  String numberOfLabours;
  String description;
  String basicPrice;
  String currentLocation;
  String shipmentImage;
  String pickUpLocationName;
  String dropOffLocationName;

  void fromMap(DocumentSnapshot doc) {
    this.shipmentId = doc.data['shipmentId'] ?? '';
    this.condition = doc.data['condition'];
    this.shipperId = doc.data['shipperId'] ?? '';
    this.customerId = doc.data['customerId'] ?? '';
    this.price = doc.data['price'];
    this.discount = doc.data['discount'] ?? '';
    this.packageType = doc.data['packageType'] ?? "";
    this.pickUpLocation = doc.data['pickUpLocation'] ?? '';
    this.currentLocation = doc.data['currentLocation'] ?? '';
    this.dropLocation = doc.data['dropLocation'] ?? '';
    this.deliveryDate = doc.data['deliveryDate'] ?? '';
    this.shipmentPackage = doc.data['shipmentPackage'] ?? '';
    this.numberOfLabours = doc.data['numberOfLabours'] ?? '';
    this.basicPrice = doc.data['basicPrice'] ?? '';
    this.shipmentImage = doc.data['shipmentImage'];
    this.totalDistance = doc.data['totalDistance'];
    this.description = doc.data['description'] ?? "";
    this.pickUpLocationName = doc.data['pickUpLocationName'] ?? "";
    this.dropOffLocationName = doc.data['dropOffLocationName'] ?? "";
  }

  Map<String,dynamic> toMap() {
    return {
      'condition': condition,
      'shipmentId': shipmentId,
      'shipperId': shipperId,
      'customerId': customerId,
      'price': price,
      'discount': discount,
      'packageType': packageType,
      'deliveryDate': deliveryDate,
      'pickUpLocation': pickUpLocation,
      'shipmentPackage': shipmentPackage,
      'totalDistance': totalDistance,
      'dropLocation': dropLocation,
      'numberOfLabours': numberOfLabours,
      'description': description,
      'basicPrice': basicPrice,
      'currentLocation': currentLocation,
      'shipmentImages': shipmentImage,
      'dropOffLocationName': dropOffLocationName,
      'pickUpLocationName': pickUpLocationName,
    };
  }

  Shipment(
      {this.condition,
        this.shipmentId,
        this.shipperId,
        this.customerId,
        this.price,
        this.discount,
        this.packageType,
        this.deliveryDate,
        this.pickUpLocation,
        this.shipmentPackage,
        this.totalDistance,
        this.dropLocation,
        this.numberOfLabours,
        this.description,
        this.basicPrice,
        this.currentLocation,
        this.shipmentImage,
        this.pickUpLocationName,
        this.dropOffLocationName});
}
