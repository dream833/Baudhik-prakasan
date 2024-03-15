// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  List<Datum>? data;

  AddressModel({
    this.data,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? userId;
  String? state;
  String? city;
  String? postalCode;
  String? area;
  String? landmark;
  int? isDelivery;
  String? addressLine1;
  String? addressLine2;

  Datum({
    this.id,
    this.userId,
    this.state,
    this.city,
    this.postalCode,
    this.area,
    this.landmark,
    this.isDelivery,
    this.addressLine1,
    this.addressLine2,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    state: json["state"],
    city: json["city"],
    postalCode: json["postal_code"],
    area: json["area"],
    landmark: json["landmark"],
    isDelivery: json["is_delivery"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "state": state,
    "city": city,
    "postal_code": postalCode,
    "area": area,
    "landmark": landmark,
    "is_delivery": isDelivery,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
  };
}
