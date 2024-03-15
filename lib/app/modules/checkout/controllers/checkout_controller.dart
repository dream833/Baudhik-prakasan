import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/widgets/custom_message.dart';

class CheckoutController extends GetxController{

  var selectedValue = RxString(""); // Observable variable initially set to null
  final userName = ''.obs;
  final userPhone = ''.obs;

  updateSelectedValue(String value) {
    selectedValue.value = value;
    debugPrint('Selected Value: ${selectedValue.value}');
    CustomMessage.successToast("Print ${selectedValue.value}");
  }


  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    final phone = prefs.getString('phone');
    userName.value = name ?? "No name found";
    userPhone.value = phone ?? "No number found";
  }

  @override
  void onClose() {
    super.onClose();
  }
}