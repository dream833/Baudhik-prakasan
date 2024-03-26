import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/model/order.dart';
import 'package:ssgc/app/modules/cart/controllers/cart_controller.dart';
import 'package:ssgc/app/modules/checkout/views/checkout_view.dart';

import '../../../api/base_client.dart';
import '../../../widgets/custom_message.dart';
import '../views/my_orders_view.dart';

class MyOrdersController extends GetxController {
  // String paymentMethod = "cash";
  //TODO: Implement MyOrdersController

  final count = 0.obs;

  final cartController = Get.find<CartController>();

  List<Data>? orderList;
  final orderItems = [].obs;
  final isLoading = false.obs;
  final isCreateOrderLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getOrder();
  }

  // void setPaymentMethod(String method) {
  //   paymentMethod = method;
  // }

  void increment() => count.value++;

  getOrder() async {
    isLoading.value = true;
    try {
      final response = await ApiBaseClient().getOrder();
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final orderModel =
            OrderModel.fromJson(jsonResponse); // Parse the JSON using CartModel
        if (orderModel.data != null) {
          orderItems.clear(); // Clear the previous list
          orderItems.addAll(
              orderModel.data!); // Add the parsed cart items to the list
          isLoading.value = false;
          print("Cart Items:");
          for (var orderItem in orderItems) {
            print("Order Status: ${orderItem.status}");
          }
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  createOrder(String? paymentMethod) async {
    isCreateOrderLoading.value = true;

    final Map<String, dynamic> data = {
      "payment_method": paymentMethod,
      "address_id": 13,
      "items": cartController
          .getCartItemsForRequest(), // Get cart items from the controller
    };
    debugPrint("payment: ${data["payment_method"]}");
    final response = await ApiBaseClient().makeOrder(data);
    // Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // navigateToCheckoutPage();
      CustomMessage.successToast("Order Successful");
      isCreateOrderLoading.value = false;
      update();
      // Get.offAll(BottomNavigationBarView());
      // Create a function to go to order page and remove this page from background
    } else if (response.statusCode == 401) {
      // print('${responseData['message']}');
      isCreateOrderLoading.value = false;
      update();
    } else {
      print("Status Code---------------> ${response.statusCode}");
      isCreateOrderLoading.value = false;
      update();
    }
  }

  deleteOrder(int id, int index) async {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.all(20),
      title: "Delete this Order",
      middleText: "Do you want to delete this order?",
      confirm: ElevatedButton(
        onPressed: () async {
          final response = await ApiBaseClient().deleteOrder(id);
          Map<String, dynamic> responseData = json.decode(response.body);
          if (response.statusCode == 200) {
            CustomMessage.successToast("Order Deleted");
            orderItems.removeAt(index);
            update();
            Get.back();
          } else if (response.statusCode == 401) {
            CustomMessage.successToast("Can't Delete Order");
            print('${responseData['message']}');
            Get.back();
          } else {
            print("Status Code ${response.statusCode.toString()}");
            Get.back();
          }
        },
        child: const Text("Yes"),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
          update();
        },
        child: const Text("No"),
      ),
    );
  }

  Future<void> navigateToCheckoutPage() async {
    Get.to(() {
      return const MyOrdersView();
    });
    final cartController = Get.find<CartController>();
    await cartController.getCart();
  }
}
