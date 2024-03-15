import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ssgc/app/data/app_image.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';

import '../../../widgets/app_color.dart';
import '../../../widgets/text.dart';
import '../../search_screen/controllers/search_screen_controller.dart';
import '../controllers/profile_controller.dart';

// ignore: must_be_immutable
class ProfileView extends GetView<ProfileController> {
  ProfileController profileController = Get.put(ProfileController());
  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());
  ProfileView({Key? key}) : super(key: key);
  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white50,
        title: BigText(text: "Profile"),
        centerTitle: true,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [

              Obx(()=>
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 65.r,
                          backgroundColor: AppColor.mainColor,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 62.r,
                              backgroundColor: AppColor.white,
                              backgroundImage: profileController.imagePath.value.isNotEmpty
                                  ? FileImage(File(profileController.imagePath.value.toString()))
                                  : const AssetImage('assets/images/person.png') as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: (){
                              controller.getImage();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: EdgeInsets.all(10.h,),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal.shade200,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ),

              SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width / 1.1,
                        child: TextFormField(
                          controller: profileController.nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              color: AppColor.black, fontSize: 13,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: AppColor.mainColor,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            hintStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF00C9A7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF00C9A7),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: Get.width / 1.1,
                        child: TextFormField(
                          controller: profileController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: AppColor.black, fontSize: 13,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: AppColor.mainColor,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            hintStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF00C9A7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF00C9A7),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: Get.width / 1.1,
                        child: TextFormField(
                          controller: profileController.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Phone',
                              labelStyle: TextStyle(
                                  color: AppColor.black, fontSize: 13),
                              floatingLabelStyle:
                                  TextStyle(color: AppColor.mainColor),
                              contentPadding: const EdgeInsets.all(16),
                              hintStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF00C9A7))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF00C9A7)))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(()=>
                        SizedBox(
                          width: Get.width / 1.1,
                          child: TextFormField(
                            readOnly: true,
                            controller: TextEditingController(
                              text: controller.selectedTime.value.format(context),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Set Study Time',
                              labelStyle: TextStyle(
                                color: AppColor.black, fontSize: 13,
                              ),
                              floatingLabelStyle: TextStyle(
                                color: AppColor.mainColor,
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              hintStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFF00C9A7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFF00C9A7),
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  print("Click");
                                  controller.selectTime(context);
                                  // controller.setStudyTime(context);
                                },
                                child: const Icon(Icons.edit_calendar_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // SizedBox(
                      //   width: Get.width / 1.1,
                      //   child: TextFormField(
                      //     controller: profileController.referralCodeController,
                      //     decoration: InputDecoration(
                      //       labelText: 'Referral Code',
                      //       labelStyle: TextStyle(
                      //         color: AppColor.black, fontSize: 13,
                      //       ),
                      //       floatingLabelStyle: TextStyle(
                      //         color: AppColor.mainColor,
                      //       ),
                      //       contentPadding: const EdgeInsets.all(16),
                      //       hintStyle: const TextStyle(fontSize: 13),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: const BorderSide(
                      //           color: Color(0xFF00C9A7),
                      //         ),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: const BorderSide(
                      //           color: Color(0xFF00C9A7),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      SmallText(
                        text: "Add New Address",
                        color: AppColor.mainColor,
                      ),
                      SizedBox(height: 16.h,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h,),
        child: Obx(()=>
          RoundedButton(
            isLoading: controller.isProfileUpdateLoading.value,
            height: 50,
            backgroundColor: AppColor.mainColor,
            text: "SUBMIT",
            onPress: (){
              print("TAPPED!");
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (controller.imagePath.value.isNotEmpty){
                  controller.updateUser();
                }
                else {
                  Get.snackbar("Warning", "Upload Image");
                }
              }
            },
          ),
        )
      ),
    );
  }
}
