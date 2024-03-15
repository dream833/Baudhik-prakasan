import 'dart:convert';

List<BookHome> bookHomeFromJson(String str) => List<BookHome>.from(json.decode(str).map((x) => BookHome.fromJson(x)));

String bookHomeToJson(List<BookHome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookHome {
  int? categoryId;
  String? categoryName;
  String? image;
  List<Book>? books;

  BookHome({
    this.categoryId,
    this.categoryName,
    this.image,
    this.books,
  });

  factory BookHome.fromJson(Map<String, dynamic> json) => BookHome(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    image: json["image"],
    books: json["books"] == null ? [] : List<Book>.from(json["books"]!.map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "image": image,
    "books": books == null ? [] : List<dynamic>.from(books!.map((x) => x.toJson())),
  };
}

class Book {
  int? bookId;
  String? bookName;
  String? image;
  int? mrp;
  dynamic rate;

  Book({
    this.bookId,
    this.bookName,
    this.image,
    this.mrp,
    this.rate,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    bookId: json["book_id"],
    bookName: json["book_name"],
    image: json["image"],
    mrp: json["mrp"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "book_id": bookId,
    "book_name": bookName,
    "image": image,
    "mrp": mrp,
    "rate": rate,
  };
}
