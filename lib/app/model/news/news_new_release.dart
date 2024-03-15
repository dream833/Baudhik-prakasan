import 'dart:convert';

List<NewsNewReleaseModel> newsNewReleaseModelFromJson(String str) => List<NewsNewReleaseModel>.from(json.decode(str).map((x) => NewsNewReleaseModel.fromJson(x)));

String newsNewReleaseModelToJson(List<NewsNewReleaseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsNewReleaseModel {
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  String? newsImage;
  int? newsId;
  String? title;
  String? description;
  String? image;
  List<dynamic>? comments;

  NewsNewReleaseModel({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.newsImage,
    this.newsId,
    this.title,
    this.description,
    this.image,
    this.comments,
  });

  factory NewsNewReleaseModel.fromJson(Map<String, dynamic> json) => NewsNewReleaseModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    newsImage: json["news_image"],
    newsId: json["news_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_image": categoryImage,
    "news_image": newsImage,
    "news_id": newsId,
    "title": title,
    "description": description,
    "image": image,
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
  };
}
