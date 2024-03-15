import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/base_client.dart';

class CustomerSupportController extends GetxController {
  //TODO: Implement CustomerSupportController

  final count = 0.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  sendMessageToCustomerSupport() async {
    isLoading.value = true;
    try {

      isLoading.value = true;
      var map = <dynamic, dynamic>{};
      map['full_name'] = nameController.text;
      map['email'] = emailController.text;
      map['message'] = messageController.text.toString();
      map['reason'] = 'Static Reason';
      // map['user_id'] = '17';
      print(map);
      dynamic response = await ApiBaseClient().sendMessageToCustomerSupport(map);
      // print(response.body);
      final decodeResponse = jsonDecode(response.body);
      print(decodeResponse);
      if (response.statusCode == 201){
        Get.snackbar("Success", 'Customer Support Added');
        isLoading.value = false;
        update();
      }
      else {
        print('Status Code ${response.statusCode}');
        isLoading.value = false;
        update();
      }
    } catch (e){
      print('Exception is:  ${e.toString()}');
      isLoading.value = false;
      update();
    }
  }

}
