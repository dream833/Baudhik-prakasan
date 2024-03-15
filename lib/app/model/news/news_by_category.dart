// To parse this JSON data, do
//
//     final newsByCategoryModel = newsByCategoryModelFromJson(jsonString);

import 'dart:convert';

List<NewsByCategoryModel> newsByCategoryModelFromJson(String str) => List<NewsByCategoryModel>.from(json.decode(str).map((x) => NewsByCategoryModel.fromJson(x)));

String newsByCategoryModelToJson(List<NewsByCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsByCategoryModel {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  String? addedBy;
  String? image;
  List<dynamic>? comments;

  NewsByCategoryModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.addedBy,
    this.image,
    this.comments,
  });

  factory NewsByCategoryModel.fromJson(Map<String, dynamic> json) => NewsByCategoryModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    addedBy: json["added_by"],
    image: json["image"],
    comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "added_by": addedBy,
    "image": image,
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
  };
}
