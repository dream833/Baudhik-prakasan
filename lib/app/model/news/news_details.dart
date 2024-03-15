// To parse this JSON data, do
//
//     final newsDetailsModel = newsDetailsModelFromJson(jsonString);

import 'dart:convert';

NewsDetailsModel newsDetailsModelFromJson(String str) => NewsDetailsModel.fromJson(json.decode(str));

String newsDetailsModelToJson(NewsDetailsModel data) => json.encode(data.toJson());

class NewsDetailsModel {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  String? addedBy;
  String? image;

  NewsDetailsModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.addedBy,
    this.image,
  });

  factory NewsDetailsModel.fromJson(Map<String, dynamic> json) => NewsDetailsModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    addedBy: json["added_by"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "added_by": addedBy,
    "image": image,
  };
}
