import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/modules/account/controllers/account_controller.dart';
import 'package:ssgc/app/modules/login/views/login_view.dart';

import '../../../api/base_client.dart';
import '../../../widgets/custom_message.dart';

class ChangePasswordController extends GetxController {

  final accountController = Get.put(AccountController());

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final isOldPasswordVisible = true.obs;
  final isNewPasswordVisible = true.obs;
  final isConfirmNewPasswordVisible = true.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  changePassword() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int? id = sp.getInt('id');
    print("Id is ------> $id");
    isLoading.value = true;
    try {
      var map = <dynamic, dynamic>{};
      map['id'] = id.toString();
      map['current_password'] = oldPasswordController.text.toString();
      map['new_password'] = newPasswordController.text.toString();

      if (oldPasswordController.text.isEmpty){
        CustomMessage.errorToast("Write your old password");
        isLoading.value = false;
        update();
      }

      else if (newPasswordController.text.isEmpty){
        CustomMessage.errorToast("Required new password");
        isLoading.value = false;
        update();
      }

      else if (newPasswordController.text.length < 8){
        CustomMessage.errorToast("Minimum password length is 8");
        isLoading.value = false;
        update();
      }

      else if (confirmNewPasswordController.text.isEmpty){
        CustomMessage.errorToast("Confirm your new password");
        isLoading.value = false;
        update();
      }

      else if (confirmNewPasswordController.text != newPasswordController.text){
        CustomMessage.errorToast("New password & Confirm password should be same");
        isLoading.value = false;
        update();
      }

      else {
        final response = await ApiBaseClient().changePassword(map);

        if(response.statusCode == 200) {
          CustomMessage.successToast("Password Change successfully");
          accountController.removeUser();
          Get.offAll(()=>LoginView());
          isLoading.value = false;
          update();
        }
        else if (response.statusCode == 401){
          // CustomMessage.errorToast('${responseData['message']}');
          // print('${responseData['message']}');
          print("Status Code 401");
          isLoading.value = false;
          update();
        }
        else {
          print("Status code ${response.statusCode}");
          CustomMessage.errorToast("Can't change password");
          isLoading.value = false;
          update();
        }
      }

    } catch (e){
      isLoading.value = false;

      update();
    }
  }



  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }
}
