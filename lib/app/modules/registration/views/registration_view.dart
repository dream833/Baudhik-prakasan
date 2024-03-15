import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ssgc/app/modules/registration/controllers/registration_controllers.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        title: Text(
          "Registration",
          style: TextStyle(
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.black,),
        backgroundColor: AppColor.white50,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Obx(()=>
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: controller.imagePath.value.isNotEmpty ?
                      FileImage(File(controller.imagePath.value.toString())) : null ,
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
            CustomTextFormField(
              controller: controller.nameController,
              currentFocus: controller.nameFocusNode,
              nextFocus: controller.phoneFocusNode,
              label: 'Name',
            ),

            SizedBox(height: 10.h,),

            CustomTextFormField(
              inputType: TextInputType.phone,
              controller: controller.phoneController,
              currentFocus: controller.phoneFocusNode,
              nextFocus: controller.passwordFocusNode,
              label: 'Phone',
            ),

            SizedBox(height: 10.h,),

            Obx(()=>
              CustomTextFormField(
                isObscure: controller.isPasswordVisible.value,
                controller: controller.passwordController,
                currentFocus: controller.passwordFocusNode,
                // nextFocus: controller.phoneFocusNode,
                label: 'Password',
                suffixIcon: controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                suffixOnPress: (){
                  controller.isPasswordVisible.value =! controller.isPasswordVisible.value;
                },
              ),
            ),

            SizedBox(height: 10.h,),

            Obx(()=>
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                  text: 'Sign Up',
                  height: 55,
                  backgroundColor: AppColor.mainColor,
                  isLoading: controller.isLoading.value,
                  onPress: (){
                    controller.userRegistration();
                  },
                ),
              ),
            ),

            SizedBox(height: 10.h,),

          ],
        ),
      ),
    );
  }
}
