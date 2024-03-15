import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/base_client.dart';
import '../../../model/wishlist/wishlist.dart';
import '../../../widgets/custom_message.dart';

class WishlistController extends GetxController {
  //TODO: Implement WishlistController

  final count = 0.obs;

  final wishList = [].obs;
  final isWishListLoading = false.obs;
  final isLoading = false.obs;
  final isAddedToWishList = false.obs;
  final wishListItemIndex = 0.obs;
  // final isAddedToWishList = false.obs;

  @override
  void onInit() {
    super.onInit();
    getWishList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getWishList() async {
    try {
      isWishListLoading.value = true;
      final response = await ApiBaseClient().getWishList();
      if (response.statusCode == 200) {
        var newReleaseList = [];
        newReleaseList = jsonDecode(response.body);
        print(response.body);
        wishList.clear();
        for (var element in newReleaseList) {
          wishList.add(WishListModel.fromJson(element));
        }
        isWishListLoading.value = false;
        update();
      } else {
        isWishListLoading.value = false;
        update();
      }
    } catch(e){
      isWishListLoading.value = false;
      update();
      print("Exception is ${e.toString()}");
    }
  }

  setToWish(){
    if (isAddedToWishList.value == false){
      isAddedToWishList.value = true;
    }
    else {
      isAddedToWishList.value = false;
    }
  }

  addToWishList(int id, String type) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isLoading.value = true;
      var map = <dynamic, dynamic>{};
      map['item_id'] = id.toString();
      map['type'] = type.toString();
      final response = await ApiBaseClient().addToWishList(map);
      if(response.statusCode == 201) {
        CustomMessage.successToast("Added to Wishlist successfully");
        isLoading.value = false;
        // getWishList();
        // isAddedToWishList.value = true;

        List<String> itemId = (prefs.getStringList('itemId') ?? [])
            .map((id) => id.toString())
            .toList();
        itemId.add(id.toString());

        await prefs.setStringList('itemId', itemId).then((value) {
          isAddedToWishList.value = true;
        });

        update();
      }
      else if (response.statusCode == 401){
        isLoading.value = false;
        update();
      }
      else {
        CustomMessage.errorToast("Can not add to cart");
        isLoading.value = false;
        update();
      }

    } catch(e){
      isLoading.value = false;
      update();
    }
  }

  Future<void> removeFromWishlistSharedPreference(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> wishlistIds = prefs.getStringList('itemId') ?? [];

      // Remove the specific ID from the list
      wishlistIds.remove(id.toString());

      // Save the updated list back to SharedPreferences
      await prefs.setStringList('itemId', wishlistIds);
    } catch (e) {
      // Handle errors
    }
  }

  deleteFromWishList(int index, int id) async {
    final response = await ApiBaseClient().deleteFromWishList(id);
    Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if(response.statusCode == 200 && responseData['message'] == "Wishlist item deleted successfully") {
      CustomMessage.successToast("Remove from wish list");
      wishList.removeAt(index);
      update();
    }
    else if (response.statusCode == 401){
      print('${responseData['message']}');
    }
  }

  deleteWishListFromProductDetails(int id) async {
    final response = await ApiBaseClient().deleteFromWishList(id);
    Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if(response.statusCode == 200 && responseData['message'] == "Wishlist item deleted successfully") {
      CustomMessage.successToast("Remove from wish list");
      // wishList.removeAt(index);
      update();
    }
    else if (response.statusCode == 401){
      print('${responseData['message']}');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
