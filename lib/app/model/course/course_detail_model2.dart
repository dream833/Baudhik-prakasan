// To parse this JSON data, do
//
//     final courseDetailsModel2 = courseDetailsModel2FromJson(jsonString);

import 'dart:convert';

CourseDetailsModel2 courseDetailsModel2FromJson(String str) => CourseDetailsModel2.fromJson(json.decode(str));

String courseDetailsModel2ToJson(CourseDetailsModel2 data) => json.encode(data.toJson());

class CourseDetailsModel2 {
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
  List<Pdf>? videos;
  List<Pdf>? tests;
  List<Pdf>? pdfs;
  int? rate; // Change this to a double
  List<Review>? reviews;

  CourseDetailsModel2({
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
    this.videos,
    this.tests,
    this.pdfs,
    this.rate,
    this.reviews,
  });

  factory CourseDetailsModel2.fromJson(Map<String, dynamic> json) => CourseDetailsModel2(
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
    images: json["images"] == null ? [] : List<String>.from(json["images"].map((x) => x)),
    videos: json["videos"] == null ? [] : List<Pdf>.from(json["videos"].map((x) => Pdf.fromJson(x))),
    tests: json["tests"] == null ? [] : List<Pdf>.from(json["tests"].map((x) => Pdf.fromJson(x))),
    pdfs: json["pdfs"] == null ? [] : List<Pdf>.from(json["pdfs"].map((x) => Pdf.fromJson(x))),
    rate: json["rate"],
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
    "tests": tests == null ? [] : List<dynamic>.from(tests!.map((x) => x.toJson())),
    "pdfs": pdfs == null ? [] : List<dynamic>.from(pdfs!.map((x) => x.toJson())),
    "rate": rate,
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
  };
}

class Pdf {
  int? dayNo;
  int? id;
  String? title;
  String? description;
  int? courseId;
  String? link;

  Pdf({
    this.dayNo,
    this.id,
    this.title,
    this.description,
    this.courseId,
    this.link,
  });

  factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
    dayNo: json["day_no"],
    id: json["id"],
    title: json["title"],
    description: json["description"],
    courseId: json["course_id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "day_no": dayNo,
    "id": id,
    "title": title,
    "description": description,
    "course_id": courseId,
    "link": link,
  };
}

class Review {
  int? id;
  int? rating;
  String? comment;
  int? userId;
  int? itemId;
  String? type;
  DateTime? createdAt;
  String? userName;

  Review({
    this.id,
    this.rating,
    this.comment,
    this.userId,
    this.itemId,
    this.type,
    this.createdAt,
    this.userName,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    rating: json["rating"],
    comment: json["comment"],
    userId: json["user_id"],
    itemId: json["item_id"],
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "comment": comment,
    "user_id": userId,
    "item_id": itemId,
    "type": type,
    "created_at": createdAt?.toIso8601String(),
    "user_name": userName,
  };
}

