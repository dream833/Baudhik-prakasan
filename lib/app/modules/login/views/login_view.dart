import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_form_data;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/modules/login/otp/otp_view_page.dart';
import 'package:ssgc/app/modules/registration/views/registration_view.dart';
import 'package:ssgc/app/widgets/custom_text_span.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';
import 'package:ssgc/app/widgets/text.dart';
import 'package:http/http.dart' as http;
import '../../../data/app_image.dart';

import '../../../widgets/app_color.dart';
import '../../bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  String? selectedValue;

  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white50,
        appBar: AppBar(
          toolbarHeight: 55.h,
          elevation: 2,
          backgroundColor: AppColor.white50,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Center(
              child: BigText(
                text: "Baudhik Prakashan Pariksha Vani",
                size: 16.h,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      BigText(
                        text: "Log In",
                        size: 25,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),

                Obx(
                  () => Visibility(
                    visible: loginController.isOtpLogin.value,
                    child: Form(
                      key: _formKey2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width / 1.1,
                              child: TextFormField(
                                controller: loginController.otpPhoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: 'Phone ',
                                  hintStyle: const TextStyle(fontSize: 13),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF00C9A7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !loginController.isOtpLogin.value,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width / 1.1,
                              child: TextFormField(
                                controller: loginController.phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: 'Phone ',
                                  hintStyle: const TextStyle(fontSize: 13),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF00C9A7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => SizedBox(
                                width: Get.width / 1.1,
                                child: TextFormField(
                                  controller:
                                      loginController.passwordController,
                                  obscureText:
                                      controller.isPasswordVisible.value,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(16),
                                    hintText: 'Password ',
                                    hintStyle: const TextStyle(fontSize: 13),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.isPasswordVisible.value =
                                            !controller.isPasswordVisible.value;
                                      },
                                      child: Icon(
                                          controller.isPasswordVisible.value
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF00C9A7),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Obx(
                  () => GestureDetector(
                    onTap: () {
                      loginController.setIsOtpOrPassword();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          Text(
                            loginController.isOtpLogin.value == true
                                ? "Login With Password"
                                : "Login with otp",
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RoundedButton(
                      isLoading: loginController.isLoading.value,
                      text: "LOGIN",
                      height: 50,
                      backgroundColor: Colors.amber.shade400,
                      onPress: () {
                        if (loginController.isOtpLogin.value) {
                          if (_formKey2.currentState!.validate()) {
                            if (loginController
                                .otpPhoneController.text.isNotEmpty) {
                              _formKey2.currentState!.save();
                              print(loginController.otpPhoneController.text);
                              loginController.sendOTP(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please Enter Phone Number");
                            }
                            // loginController.loginUser();
                          }
                          // else {
                          //   print("Form not validate");
                          // }
                          print("Otp Login called");
                        } else {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Get.snackbar("Warning", "Password Login");
                            loginController.loginUser();
                          }
                          // else {
                          //   print("Form not validate");
                          // }
                          print("Password Login called");
                        }
                      },
                    ),
                  ),
                ),

                // GestureDetector(
                //   onTap: () {
                //     if (_formKey.currentState!.validate()) {
                //       _formKey.currentState!.save();
                //       loginController.loginUser();
                //     }
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(10),
                //     child: Container(
                //       padding: const EdgeInsets.all(20),
                //       height: 55,
                //       decoration: BoxDecoration(
                //           color: Colors.grey,
                //           borderRadius: BorderRadius.circular(10)),
                //       child: Center(
                //         child: BigText(
                //           text: "LOG IN",
                //           color: Colors.white,
                //           size: 15,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 25.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const RegistrationView(),
                    );
                  },
                  child: const CustomTextSpan(
                    title: "No account yet? ",
                    text: 'Sign up with password',
                  ),
                ),

                SizedBox(
                  height: 25.h,
                ),

                SmallText(
                  text: "Or Log In Using Social Media",
                  color: Colors.grey,
                  size: 14,
                ),
                const SizedBox(
                  height: 25,
                ),
                GetBuilder<LoginController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      controller.googleLogin();
                    },
                    child: SignOptions(
                      icon: Icons.phone_android,
                      text: "Sign in with Google",
                      image: AssetImage(AppImage.google),
                    ),
                  );
                }),
                SignOptions(
                  icon: Icons.phone_android,
                  text: "Sign in with Facebook",
                  backgroundColor: Colors.blue,
                  image: AssetImage(AppImage.facebook),
                ),
                const SizedBox(
                  height: 50,
                ),
                // GestureDetector(
                //   onTap: () async {
                //     Get.offAll(() => BottomNavigationBarView());
                //   },
                //   child: SmallText(
                //     text: "Guest User",
                //     color: AppColor.mainColor,
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}

class SignOptions extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color color;
  final AssetImage image;
  const SignOptions(
      {super.key,
      required this.icon,
      required this.text,
      this.backgroundColor = Colors.white,
      this.color = Colors.black,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 14,
            backgroundImage: image,
          ),
          BigText(
            text: text,
            color: color,
            size: 15,
          ),
          Icon(
            Icons.abc,
            color: backgroundColor,
          )
        ],
      ),
    );
  }
}
