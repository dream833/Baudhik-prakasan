import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  List<CartItem>? cartItems;

  CartModel({
    this.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    cartItems: json["cartItems"] == null ? [] : List<CartItem>.from(json["cartItems"]!.map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cartItems": cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
  };
}

class CartItem {
  int? id;
  int? itemId;
  String? type;
  int? quantity;
  int? userId;
  String? name;
  int? bookId;
  int? price;
  int? totalPrice;
  String? image;

  CartItem({
    this.id,
    this.itemId,
    this.type,
    this.quantity,
    this.userId,
    this.name,
    this.bookId,
    this.price,
    this.totalPrice,
    this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"],
    itemId: json["item_id"],
    type: json["type"],
    quantity: json["quantity"],
    userId: json["user_id"],
    name: json["name"],
    bookId: json["book_id"],
    price: json["price"],
    totalPrice: json["total_price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemId,
    "type": type,
    "quantity": quantity,
    "user_id": userId,
    "name": name,
    "book_id": bookId,
    "price": price,
    "total_price": totalPrice,
    "image": image,
  };
}
