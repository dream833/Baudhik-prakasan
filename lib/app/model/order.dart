import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  List<Data>? data;

  OrderModel({
    this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  int? id;
  int? userId;
  String? paymentMethod;
  int? addressId;
  String? status;
  int? totalPrice;
  DateTime? createdAt;

  Data({
    this.id,
    this.userId,
    this.paymentMethod,
    this.addressId,
    this.status,
    this.totalPrice,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    paymentMethod: json["payment_method"],
    addressId: json["address_id"],
    status: json["status"],
    totalPrice: json["total_price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "payment_method": paymentMethod,
    "address_id": addressId,
    "status": status,
    "total_price": totalPrice,
    "created_at": createdAt?.toIso8601String(),
  };
}
