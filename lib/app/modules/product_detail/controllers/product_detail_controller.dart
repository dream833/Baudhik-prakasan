import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/api/base_client.dart';
import 'package:ssgc/app/modules/cart/controllers/cart_controller.dart';

import '../../../model/book_details.dart';
import 'package:http/http.dart' as http;

import '../../../utils/globals.dart';
import '../../cart/views/cart_view.dart';

class ProductDetailController extends GetxController {

  final productDetails = BookDetails().obs;
  RxBool isLoading = false.obs;
  var productData = {}.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchProductData();
    // fetchProductDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }


  setProductDetails(BookDetails bookDetails){
    productDetails.value = bookDetails;
  }

  fetchProductDetails(int id) async {
    isLoading.value = true;
    try {
      final response = await ApiBaseClient().getProductDetails(id);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final details = BookDetails.fromJson(jsonData);
        setProductDetails(details);
        print("========== Product Details ===========");
        print(response.body);
        print('==============================');
        isLoading.value = false;
      } else {
        print(response.statusCode.toString());
        // Handle error here
        print('Failed to fetch product details');
        isLoading.value = false;
      }
    } catch (e) {
      // Handle error here
      print('My Error here is : $e');
      isLoading.value = false;
    }
  }

  Future<void> navigateToCartPage() async {
    Get.to(() {
      return CartView();
    });
    final cartController = Get.find<CartController>();
    await cartController.getCart();
  }


}
