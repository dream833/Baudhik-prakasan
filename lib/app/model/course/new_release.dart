// To parse this JSON data, do
//
//     final newReleaseModel = newReleaseModelFromJson(jsonString);

import 'dart:convert';

List<NewReleaseModel> newReleaseModelFromJson(String str) => List<NewReleaseModel>.from(json.decode(str).map((x) => NewReleaseModel.fromJson(x)));

String newReleaseModelToJson(List<NewReleaseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewReleaseModel {
  int? categoryId;
  String? categoryName;
  int? id;
  String? name;
  String? description;
  int? mrp;
  int? discount;
  String? type;
  String? lang;
  int? isFree;
  DateTime? createdAt;
  String? image;

  NewReleaseModel({
    this.categoryId,
    this.categoryName,
    this.id,
    this.name,
    this.description,
    this.mrp,
    this.discount,
    this.type,
    this.lang,
    this.isFree,
    this.createdAt,
    this.image,
  });

  factory NewReleaseModel.fromJson(Map<String, dynamic> json) => NewReleaseModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    id: json["id"],
    name: json["name"],
    description: json["description"],
    mrp: json["mrp"],
    discount: json["discount"],
    type: json["type"],
    lang: json["lang"],
    isFree: json["is_free"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "id": id,
    "name": name,
    "description": description,
    "mrp": mrp,
    "discount": discount,
    "type": type,
    "lang": lang,
    "is_free": isFree,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "image": image,
  };
}
