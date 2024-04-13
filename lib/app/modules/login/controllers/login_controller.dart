import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/profile/controllers/profile_controller.dart';
import 'package:ssgc/app/modules/registration/views/registration_view.dart';
import 'package:ssgc/app/widgets/custom_message.dart';

import '../../../api/base_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../otp/otp_view_page.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final profileController = Get.put(ProfileController());

  final count = 0.obs;
  final isLoading = false.obs;
  final phoneController = TextEditingController();
  final otpPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  final isOtpLogin = true.obs;

  final isPasswordVisible = true.obs;

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
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

  setIsOtpOrPassword() {
    isOtpLogin.value = !isOtpLogin.value;
    print(isOtpLogin.value);
  }

  changeRoute({required String phone}) async {
    await Future.delayed(const Duration(seconds: 1), () {
      Get.to(
        () => OTPViewPage(
          phone: phone,
        ),
      );
    });
  }

  Future<void> sendOTP(context) async {
    isLoading.value = true;
    final loginphoneController = otpPhoneController.text;
    final contacts = loginphoneController;
    final data = json.encode({
      "phone": "+91$loginphoneController",
    });
    final response = await Dio().post(
      'https://api.bhattacharjeesolution.in/book/api/user-otp-login.php',
      data: data,
      options: Options(
          headers: {
            "Accept": "application/json",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );

    //final response = await http.post(apiURL{});
    if (response.statusCode == 200) {
      changeRoute(phone: loginphoneController);
      print('Response: ${response.data} $loginphoneController');
      isLoading.value = false;
    } else {
      Fluttertoast.showToast(
          msg:
              'Login failed. Status code: ${response.statusCode} ${response.data}');
      print(
          'Login failed. Status code: ${response.statusCode} ${response.data}');
      print(loginphoneController);
      isLoading.value = false;
    }
  }

  // loginUserwithOTP() async{
  //   isLoading.value = true;
  //   var data
  // }
  Future<void> verify(final phone, String otp) async {
    print("+91$phone + $otp");
    final data = {
      "phone": "+91$phone",
      "otp": otp,
    };
    final response = await ApiBaseClient().loginUserwithOTP(data);
    Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (response.statusCode == 200) {
      debugPrint("verify successful");
      print(otp);
      String token = responseData['token'];
      String name = responseData['user']['name'];
      String phone = responseData['user']['phone'];
      int id = responseData['user']['id'];
      storeUserInfo(token, name, phone, id).then((value) {
        print("Store on local DB successfully");
        profileController.getUserData();
      });
      CustomMessage.successToast("Login Successful");
      Get.offAll(BottomNavigationBarView());
      isLoading.value = false;
      isOtpLogin.value = true;
      update();
    } else {
      if (responseData['message'] == 'User not found') {
        CustomMessage.errorToast("User not found please register");
        Get.to(() => const RegistrationView());
      } else {
        Fluttertoast.showToast(
          msg:
              'Login failed. Status code: ${response.statusCode} ${response.data}',
        );
        debugPrint(response.statusCode!.toString() +
            json.encode(response.data.toString()));
      }
    }
  }

  loginUser() async {
    isLoading.value = true;
    var data = {
      'phone': phoneController.text.toString().trim(),
      'password': passwordController.text.toString().trim(),
    };
    final response = await ApiBaseClient().loginUserwithPassword(data);
    Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (response.statusCode == 200) {
      print(("Login Success"));
      String token = responseData['token'];
      String name = responseData['user']['name'];
      String phone = responseData['user']['phone'];
      int id = responseData['user']['id'];
      storeUserInfo(token, name, phone, id).then((value) {
        print("Store on local DB successfully");
        profileController.getUserData();
      });
      CustomMessage.successToast("Login Successful");
      Get.offAll(BottomNavigationBarView());
      isLoading.value = false;
      isOtpLogin.value = true;
      update();
    } else if (response.statusCode == 401) {
      print('${responseData['message']}');
      CustomMessage.errorToast("${responseData['message']}");
      isLoading.value = false;
      update();
    } else {
      CustomMessage.errorToast("Status Code ${response.statusCode}");
      isLoading.value = false;
      update();
    }
  }

  Future<void> storeUserInfo(
    String token,
    String name,
    String phone,
    int id,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('name', name);
    await prefs.setString('phone', phone);
    await prefs.setInt('id', id);
  }

  Future<bool> saveUserToken(String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", token);
    return true;
  }

  Future<bool> saveUserName(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("name", name);
    return true;
  }

  Future<bool> saveUserPhone(String phone) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("phone", phone);
    return true;
  }

  Future<bool> saveUserID(int id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("id", id);
    return true;
  }

  checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // final role = prefs.getString('role');
    // final name = prefs.getString('name');
    print("Token is =================> $token");

    if (token != null) {
      Timer(const Duration(milliseconds: 100), () {
        Get.offAll(BottomNavigationBarView());
      });
    }
    // else {
    //   Future.delayed(Duration(seconds: 2), () {
    //     Get.offAll(BottomNavigationBarView());
    //   });
    // }
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    update();
  }
}
