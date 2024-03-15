import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/modules/cart/views/cart_view.dart';

import '../../../api/base_client.dart';
import '../../../model/cart.dart';
import '../../../widgets/custom_message.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  final count = 0.obs;
  final isChecked = false.obs;
  final myCoins = 100.obs;
  final isPageLoading = false.obs;

  final isLoading = false.obs;
  final isCartItemLoading = true.obs;

  // final cart = Cart();
  final cartItems = [].obs;
  final totalPrice = 0.obs;
  final cartQuantity = 0.obs;

  @override
  void onInit() {
    super.onInit();
    calculateTotalCartPrice();
    showPageWithDelay();
    totalCartItem();
    // getCart();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  totalCartItem() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // cartQuantity.value  = sp.getInt('cartLength')!;
    int? cartLength = sp.getInt('cartLength');
    cartQuantity.value = cartLength ?? 0;
  }

  void showPageWithDelay() {
    isPageLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      isPageLoading.value = false;
      getCart();
    });
  }

  addToCart(int bookId) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      isLoading.value = true;
      var map = new Map<dynamic, dynamic>();
      map['item_id'] = bookId.toString();
      map['quantity'] = "1";
      final response = await ApiBaseClient().addToCart(map);
      Map<String, dynamic> responseData = json.decode(response.body);
      if(response.statusCode == 200 && responseData['message'] == "Item added to cart successfully") {
        CustomMessage.successToast("Added to cart successfully");
        getCart();
        cartQuantity.value = cartItems.length + 1;
        sp.setInt('cartLength', cartQuantity.value);
        isLoading.value = false;
        update();
      }

      else if(response.statusCode == 200 && responseData['message'] == "Item quantity updated successfully") {
        CustomMessage.successToast("Item quantity updated");
        isLoading.value = false;
        update();
      }

      else if (response.statusCode == 401){
        isLoading.value = false;
        update();
      }
      else if (response.statusCode == 201){
        CustomMessage.successToast("Added to cart successfully");
        isLoading.value = false;
        update();
      }
      else {
        print("Status code ${response.statusCode}");
        CustomMessage.errorToast("Can not add to cart");
        isLoading.value = false;
        update();
      }
    }catch(e){
      print("Error is ---------------------> ${e.toString()}");
      isLoading.value = false;
      update();
    }
  }

  getCart() async {
    isCartItemLoading.value = true;
    try {
      final response = await ApiBaseClient().getCartItem();
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final cartModel = CartModel.fromJson(jsonResponse); // Parse the JSON using CartModel
        if (cartModel.cartItems != null) {
          cartItems.clear();
          cartItems.addAll(cartModel.cartItems!);
          isCartItemLoading.value = false;
        } else {
          isCartItemLoading.value = false;
          print("==================Error===============");
          print("Invalid data format in JSON response.");
        }
      } else {
        isCartItemLoading.value = false;
      }
    } catch (e) {
      isCartItemLoading.value = false;
    }
  }

  double calculateTotalCartPrice() {
    double total = 0.0;
    for (var cartItem in cartItems) {
      if (cartItem.totalPrice != null) {
        total += cartItem.totalPrice!;
      }
    }
    return total;
  }

  void incrementItemQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity++;
      cartItems[index].totalPrice = cartItems[index].quantity * cartItems[index].price;

      // Print increment quantity and total price
      print("Incremented quantity for ${cartItems[index].name} to ${cartItems[index].quantity}");
      print("New total price for ${cartItems[index].name}: ${cartItems[index].totalPrice}");
      var id = cartItems[index].id;
      var quantity = cartItems[index].quantity;

      updateCart(id, quantity);

      update(); // Update the UI to reflect the changes
    }
  }

  void decrementItemQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity > 0) {
        cartItems[index].quantity--;
        cartItems[index].totalPrice = cartItems[index].quantity * cartItems[index].price;

        // Print decrement quantity and total price
        print("Decremented quantity for ${cartItems[index].name} to ${cartItems[index].quantity}");
        print("New total price for ${cartItems[index].name}: ${cartItems[index].totalPrice}");

        var id = cartItems[index].id;
        var quantity = cartItems[index].quantity;

        updateCart(id, quantity);


        if (cartItems[index].quantity == 0){
          cartItems.removeAt(index);
        }

        // if (cartItems[index].quantity == 0) {
        //   // Remove the item from the list if quantity becomes 0
        //   Get.defaultDialog(
        //     title: "Remove Item",
        //     middleText: "Do you want to remove this item from the cart?",
        //     confirm: ElevatedButton(
        //       onPressed: () {
        //         cartItems.removeAt(index); // Remove the item from the list
        //         Get.back(); // Close the dialog
        //         calculateTotalCartPrice();
        //         update(); // Update the UI to reflect the changes
        //       },
        //       child: Text("Yes"),
        //     ),
        //     cancel: ElevatedButton(
        //       onPressed: () {
        //         // Cancel the removal by doing nothing
        //         Get.back(); // Close the dialog
        //         cartItems[index].quantity = 1;
        //         calculateTotalCartPrice();
        //         update();
        //       },
        //       child: Text("No"),
        //     ),
        //   );
        // }
        // else{
        //   calculateTotalCartPrice();
        // }

        update(); // Update the UI to reflect the changes
      }
    }
  }

  updateCart(int id, int quantity) async {
    isLoading.value = true;
    var data  = {
      'id': id,
      'quantity': quantity,
    };
    final response = await ApiBaseClient().updateCart(data);
    Map<String, dynamic> responseData = json.decode(response.body);
    if(response.statusCode == 200) {
      CustomMessage.successToast("Cart quantity updated");
    }
    else if (response.statusCode == 401){
      print('${responseData['message']}');
    }
  }

  deleteAItem(int id, int index) async {
    final response = await ApiBaseClient().deleteAItem(id);
    Map<String, dynamic> responseData = json.decode(response.body);
    if(response.statusCode == 200) {
      CustomMessage.successToast("Cart quantity updated");
      cartItems.removeAt(index);
      calculateTotalCartPrice();
      update();
    }
    else if (response.statusCode == 401){
      print('${responseData['message']}');
    }
  }

  List<Map<String, dynamic>> getCartItemsForRequest() {
    return cartItems.map((item) {
      return {
        "item_id": item.bookId,
        "quantity": item.quantity,
      };
    }).toList();
  }




}
