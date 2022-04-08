class AddShipment {
  CreateShippment createShippment;

  AddShipment({this.createShippment});

  AddShipment.fromJson(Map<String, dynamic> json) {
    createShippment = json['createShippment'] != null
        ? new CreateShippment.fromJson(json['createShippment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.createShippment != null) {
      data['createShippment'] = this.createShippment.toJson();
    }
    return data;
  }
}

class CreateShippment {
  Shippment shippment;

  CreateShippment({this.shippment});

  CreateShippment.fromJson(Map<String, dynamic> json) {
    shippment = json['shippment'] != null
        ? new Shippment.fromJson(json['shippment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippment != null) {
      data['shippment'] = this.shippment.toJson();
    }
    return data;
  }
}

class Shippment {
  int shipmentWeight;
  bool packingService;
  bool loadingService;
  PickupLocation pickupLocation;
  PickupLocation dropOffLocation;
  Shipper shipper;

  Shippment(
      {this.shipmentWeight,
      this.packingService,
      this.loadingService,
      this.pickupLocation,
      this.dropOffLocation,
      this.shipper});

  Shippment.fromJson(Map<String, dynamic> json) {
    shipmentWeight = json['shipment_weight'];
    packingService = json['packing_service'];
    loadingService = json['loading_service'];
    pickupLocation = json['pickup_location'] != null
        ? new PickupLocation.fromJson(json['pickup_location'])
        : null;
    dropOffLocation = json['drop_off_location'] != null
        ? new PickupLocation.fromJson(json['drop_off_location'])
        : null;
    shipper =
        json['shipper'] != null ? new Shipper.fromJson(json['shipper']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipment_weight'] = this.shipmentWeight;
    data['packing_service'] = this.packingService;
    data['loading_service'] = this.loadingService;
    if (this.pickupLocation != null) {
      data['pickup_location'] = this.pickupLocation.toJson();
    }
    if (this.dropOffLocation != null) {
      data['drop_off_location'] = this.dropOffLocation.toJson();
    }
    if (this.shipper != null) {
      data['shipper'] = this.shipper.toJson();
    }
    return data;
  }
}

class PickupLocation {
  String latitude;
  String longitude;

  PickupLocation({this.latitude, this.longitude});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Shipper {
  User user;

  Shipper({this.user});

  Shipper.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String id;

  User({this.id});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
