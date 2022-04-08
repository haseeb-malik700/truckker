class Shipment {
  Shipper shipper;

  Shipment({this.shipper});

  Shipment.fromJson(Map<String, dynamic> json) {
    shipper =
        json['shipper'] != null ? new Shipper.fromJson(json['shipper']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shipper != null) {
      data['shipper'] = this.shipper.toJson();
    }
    return data;
  }
}

class Shipper {
  List<Shippments> shippments;

  Shipper({this.shippments});

  Shipper.fromJson(Map<String, dynamic> json) {
    if (json['shippments'] != null) {
      shippments = new List<Shippments>();
      json['shippments'].forEach((v) {
        shippments.add(new Shippments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippments != null) {
      data['shippments'] = this.shippments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shippments {
  String delievryDate;
  Payment payment;
  List<ShipmentPicture> shipmentPicture;

  Shippments({this.delievryDate, this.payment, this.shipmentPicture});

  Shippments.fromJson(Map<String, dynamic> json) {
    delievryDate = json['delievry_date'];
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    if (json['shipment_picture'] != null) {
      shipmentPicture = new List<ShipmentPicture>();
      json['shipment_picture'].forEach((v) {
        shipmentPicture.add(new ShipmentPicture.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delievry_date'] = this.delievryDate;
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    if (this.shipmentPicture != null) {
      data['shipment_picture'] =
          this.shipmentPicture.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payment {
  int costOfDelivery;

  Payment({this.costOfDelivery});

  Payment.fromJson(Map<String, dynamic> json) {
    costOfDelivery = json['cost_of_delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost_of_delivery'] = this.costOfDelivery;
    return data;
  }
}

class ShipmentPicture {
  String url;

  ShipmentPicture({this.url});

  ShipmentPicture.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}