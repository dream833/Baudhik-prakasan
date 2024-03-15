import 'dart:convert';

List<WishListModel> wishListModelFromJson(String str) => List<WishListModel>.from(json.decode(str).map((x) => WishListModel.fromJson(x)));

String wishListModelToJson(List<WishListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishListModel {
  int? id;
  int? userId;
  int? itemId;
  String? type;

  WishListModel({
    this.id,
    this.userId,
    this.itemId,
    this.type,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    id: json["id"],
    userId: json["user_id"],
    itemId: json["item_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "item_id": itemId,
    "type": type,
  };
}
