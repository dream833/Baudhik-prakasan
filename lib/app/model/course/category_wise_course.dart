// To parse this JSON data, do
//
//     final categoryWiseCourseModel = categoryWiseCourseModelFromJson(jsonString);

import 'dart:convert';

List<CategoryWiseCourseModel> categoryWiseCourseModelFromJson(String str) => List<CategoryWiseCourseModel>.from(json.decode(str).map((x) => CategoryWiseCourseModel.fromJson(x)));

String categoryWiseCourseModelToJson(List<CategoryWiseCourseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryWiseCourseModel {
  int? id;
  String? name;
  String? description;
  int? mrp;
  int? discount;
  int? categoryId;
  String? type;
  String? lang;
  int? isFree;
  DateTime? createdAt;
  String? image;

  CategoryWiseCourseModel({
    this.id,
    this.name,
    this.description,
    this.mrp,
    this.discount,
    this.categoryId,
    this.type,
    this.lang,
    this.isFree,
    this.createdAt,
    this.image,
  });

  factory CategoryWiseCourseModel.fromJson(Map<String, dynamic> json) => CategoryWiseCourseModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    mrp: json["mrp"],
    discount: json["discount"],
    categoryId: json["category_id"],
    type: json["type"],
    lang: json["lang"],
    isFree: json["is_free"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "mrp": mrp,
    "discount": discount,
    "category_id": categoryId,
    "type": type,
    "lang": lang,
    "is_free": isFree,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "image": image,
  };
}
