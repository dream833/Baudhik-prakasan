// To parse this JSON data, do
//
//     final courseDetailsModel = courseDetailsModelFromJson(jsonString);

import 'dart:convert';

CourseDetailsModel courseDetailsModelFromJson(String str) => CourseDetailsModel.fromJson(json.decode(str));

String courseDetailsModelToJson(CourseDetailsModel data) => json.encode(data.toJson());

class CourseDetailsModel {
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
  List<String>? images;

  CourseDetailsModel({
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
    this.images,
  });

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) => CourseDetailsModel(
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
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
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
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}
