import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';
import '../controllers/customer_support_controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/app_color.dart';
import '../../../widgets/text.dart';
import '../../search_screen/controllers/search_screen_controller.dart';

// ignore: must_be_immutable
class CustomerSupportView extends GetView<CustomerSupportController> {
  CustomerSupportController customerSupportController =
      Get.put(CustomerSupportController());
  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());
  CustomerSupportView({Key? key}) : super(key: key);
  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white50,
        title: BigText(text: "Customer Support"),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                BigText(
                  text: "Send Us Message",
                  size: 16,
                ),
                const SizedBox(
                  height: 20,
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
                            controller:
                                customerSupportController.nameController,
                            decoration: InputDecoration(
                                labelText: 'Full Name',
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
                        SizedBox(
                          width: Get.width / 1.1,
                          child: TextFormField(
                            controller: customerSupportController.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: AppColor.black, fontSize: 13,
                              ),
                              floatingLabelStyle: TextStyle(color: AppColor.mainColor),
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
                          child: DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 13.5, horizontal: 0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF00C9A7))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF00C9A7))),
                            ),
                            hint: const Text(
                              'Select',
                              style: TextStyle(fontSize: 13),
                            ),
                            items: searchScreenController.searchItems
                                .map((item) => DropdownMenuItem<String>(
                                    value: item, child: SmallText(text: item)))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: Get.width / 1.1,
                          child: TextFormField(
                            maxLines: 10,
                            minLines: 5,
                            controller:
                                customerSupportController.messageController,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: 'Message',
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
                                      color: Color(0xFF00C9A7))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        Obx(()=>
                          RoundedButton(
                            text: "SUBMIT",
                            isLoading: controller.isLoading.value,
                            backgroundColor: AppColor.mainColor,
                            height: 50.h,
                            onPress: (){
                              controller.sendMessageToCustomerSupport();
                            },
                          ),
                        ),

                        // GestureDetector(
                        //   onTap: (){
                        //     print("Click");
                        //     controller.sendMessageToCustomerSupport();
                        //   },
                        //   child: Padding(
                        //     padding: EdgeInsets.all(10.r),
                        //     child: Container(
                        //       padding: EdgeInsets.all(16.r),
                        //       // height: 55,
                        //       decoration: BoxDecoration(
                        //           color: AppColor.mainColor,
                        //           borderRadius: BorderRadius.circular(10)),
                        //       child: Center(
                        //         child: BigText(
                        //           text: "SUBMIT",
                        //           color: Colors.white,
                        //           size: 15,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        SmallText(
                          text: "View Support History",
                          color: AppColor.mainColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              BigText(
                                text: "Question About An Issue ?",
                                size: 17,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Container(
                                padding: EdgeInsets.all(20.r),
                                height: 55.h,
                                width: Get.width / 2.5,
                                decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: BigText(
                                    text: "CHAT WITH US",
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                height: 55.h,
                                width: Get.width / 2.5,
                                decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: BigText(
                                    text: "CALL US",
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
