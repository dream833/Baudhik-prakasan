// To parse this JSON data, do
//
//     final homeNewsModel = homeNewsModelFromJson(jsonString);

import 'dart:convert';

List<HomeNewsModel> homeNewsModelFromJson(String str) => List<HomeNewsModel>.from(json.decode(str).map((x) => HomeNewsModel.fromJson(x)));

String homeNewsModelToJson(List<HomeNewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeNewsModel {
  int? categoryId;
  String? categoryName;
  String? image;
  List<dynamic>? news;
  List<Book>? books;

  HomeNewsModel({
    this.categoryId,
    this.categoryName,
    this.image,
    this.news,
    this.books,
  });

  factory HomeNewsModel.fromJson(Map<String, dynamic> json) => HomeNewsModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    image: json["image"],
    news: json["news"] == null ? [] : List<dynamic>.from(json["news"]!.map((x) => x)),
    books: json["books"] == null ? [] : List<Book>.from(json["books"]!.map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "image": image,
    "news": news == null ? [] : List<dynamic>.from(news!.map((x) => x)),
    "books": books == null ? [] : List<dynamic>.from(books!.map((x) => x.toJson())),
  };
}

class Book {
  int? newsId;
  String? title;
  String? description;
  String? image;
  List<dynamic>? comments;

  Book({
    this.newsId,
    this.title,
    this.description,
    this.image,
    this.comments,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    newsId: json["news_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "news_id": newsId,
    "title": title,
    "description": description,
    "image": image,
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
  };
}
