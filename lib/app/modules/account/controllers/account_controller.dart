import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../change_password/views/change_password_view.dart';

class AccountController extends GetxController {
  //TODO: Implement AccountController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getToken();
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

  removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    return token;
  }

  isUserLoggedIn(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    if (token == null || token.isEmpty){
      print("User is not login");
      await showLoginDialog(context);
    }
    else {
      print("User is logged in");
      Get.to(()=> ChangePasswordView());
    }
  }

  Future<void> showLoginDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('User Not Logged In'),
            content: Text('Please log in to change the password'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

}
