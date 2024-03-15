// To parse this JSON data, do
//
//     final newRelease = newReleaseFromJson(jsonString);

import 'dart:convert';

List<NewRelease> newReleaseFromJson(String str) => List<NewRelease>.from(json.decode(str).map((x) => NewRelease.fromJson(x)));

String newReleaseToJson(List<NewRelease> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewRelease {
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  int? bookId;
  String? bookName;
  int? mrp;
  String? image;
  dynamic rate;

  NewRelease({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.bookId,
    this.bookName,
    this.mrp,
    this.image,
    this.rate,
  });

  factory NewRelease.fromJson(Map<String, dynamic> json) => NewRelease(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    bookId: json["book_id"],
    bookName: json["book_name"],
    mrp: json["mrp"],
    image: json["image"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_image": categoryImage,
    "book_id": bookId,
    "book_name": bookName,
    "mrp": mrp,
    "image": image,
    "rate": rate,
  };
}
