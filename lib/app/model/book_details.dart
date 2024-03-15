// To parse this JSON data, do
//
//     final bookDetails = bookDetailsFromJson(jsonString);

import 'dart:convert';

BookDetails bookDetailsFromJson(String str) => BookDetails.fromJson(json.decode(str));

String bookDetailsToJson(BookDetails data) => json.encode(data.toJson());

class BookDetails {
  int? id;
  String? name;
  String? description;
  int? categoryId;
  int? quantity;
  int? price;
  int? discount;
  int? mrp;
  dynamic barcode;
  String? sample;
  int? deliveryPrice;
  int? sold;
  String? lang;
  dynamic rate;
  DateTime? createdAt;
  List<String>? images;
  List<Related>? related;
  List<Review>? reviews;

  BookDetails({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.quantity,
    this.price,
    this.discount,
    this.mrp,
    this.barcode,
    this.sample,
    this.deliveryPrice,
    this.sold,
    this.lang,
    this.rate,
    this.createdAt,
    this.images,
    this.related,
    this.reviews,
  });

  factory BookDetails.fromJson(Map<String, dynamic> json) => BookDetails(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    categoryId: json["categoryId"],
    quantity: json["quantity"],
    price: json["price"],
    discount: json["discount"],
    mrp: json["mrp"],
    barcode: json["barcode"],
    sample: json["sample"],
    deliveryPrice: json["delivery_price"],
    sold: json["sold"],
    lang: json["lang"],
    rate: json["rate"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    related: json["related"] == null ? [] : List<Related>.from(json["related"]!.map((x) => Related.fromJson(x))),
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "categoryId": categoryId,
    "quantity": quantity,
    "price": price,
    "discount": discount,
    "mrp": mrp,
    "barcode": barcode,
    "sample": sample,
    "delivery_price": deliveryPrice,
    "sold": sold,
    "lang": lang,
    "rate": rate,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "related": related == null ? [] : List<dynamic>.from(related!.map((x) => x.toJson())),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
  };
}

class Related {
  int? id;
  String? name;
  int? mrp;
  int? discount;
  dynamic rate;
  String? image;

  Related({
    this.id,
    this.name,
    this.mrp,
    this.discount,
    this.rate,
    this.image,
  });

  factory Related.fromJson(Map<String, dynamic> json) => Related(
    id: json["id"],
    name: json["name"],
    mrp: json["mrp"],
    discount: json["discount"],
    rate: json["rate"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mrp": mrp,
    "discount": discount,
    "rate": rate,
    "image": image,
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
