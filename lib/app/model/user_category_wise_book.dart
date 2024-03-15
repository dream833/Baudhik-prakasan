import 'dart:convert';

List<UserCategoryWiseBook> userCategoryWiseBookFromJson(String str) => List<UserCategoryWiseBook>.from(json.decode(str).map((x) => UserCategoryWiseBook.fromJson(x)));

String userCategoryWiseBookToJson(List<UserCategoryWiseBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserCategoryWiseBook {
  int? id;
  String? name;
  int? mrp;
  int? discount;
  dynamic rate;
  String? image;

  UserCategoryWiseBook({
    this.id,
    this.name,
    this.mrp,
    this.discount,
    this.rate,
    this.image,
  });

  factory UserCategoryWiseBook.fromJson(Map<String, dynamic> json) => UserCategoryWiseBook(
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
