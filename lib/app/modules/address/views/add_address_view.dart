import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssgc/app/modules/address/controllers/address_controller.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';

import '../../../widgets/custom_text_form_field.dart';
import 'package:get/get.dart';

class AddAddressView extends StatelessWidget {
  const AddAddressView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address", style: TextStyle(color: AppColor.black,),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: addressController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5,),
                    child: Text(
                      "Address Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  CustomTextFormField(
                    controller: addressController.stateController,
                    currentFocus: addressController.stateFocusNode,
                    nextFocus: addressController.cityFocusNode,
                    emptyMessage: "Write your state",
                    label: "State Name",
                  ),

                  CustomTextFormField(
                    controller: addressController.cityController,
                    currentFocus: addressController.cityFocusNode,
                    nextFocus: addressController.postCodeFocusNode,
                    emptyMessage: "Write your city name",
                    label: "City Name",
                  ),

                  CustomTextFormField(
                    controller: addressController.postCodeController,
                    currentFocus: addressController.postCodeFocusNode,
                    nextFocus: addressController.areaFocusNode,
                    emptyMessage: "Write your post code",
                    label: "Post Code",
                  ),

                  CustomTextFormField(
                    controller: addressController.areaController,
                    currentFocus: addressController.areaFocusNode,
                    emptyMessage: "Write your area",
                    label: "Area Name",
                  ),

                  const SizedBox(height: 16,),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5,),
                    child: Text(
                      "Location Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  CustomTextFormField(
                    controller: addressController.landMarkController,
                    currentFocus: addressController.landMarkFocusNode,
                    nextFocus: addressController.addressLine1FocusNode,
                    emptyMessage: "Land Mark",
                    label: "Land Mark",
                  ),

                  CustomTextFormField(
                    controller: addressController.addressLine1Controller,
                    currentFocus: addressController.addressLine1FocusNode,
                    nextFocus: addressController.addressLine2FocusNode,
                    emptyMessage: "Address Line 1",
                    label: "Address Line 1",
                  ),

                  CustomTextFormField(
                    controller: addressController.addressLine2Controller,
                    currentFocus: addressController.addressLine2FocusNode,
                    emptyMessage: "Address Line 2",
                    label: "Address Line 2",
                  ),

                  SizedBox(height: 16,),

                  Obx(() => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Delivery Address",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        Switch(
                            value: addressController.isSwitched.value,
                            onChanged: (value) {
                              addressController.updateSwitchValue(value); // Update the switch state
                            },
                          ),
                      ],
                    ),
                  ),
                  ),

                  SizedBox(height: 16,),


                  Obx(()=>
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 16,),
                      child: RoundedButton(
                        height: 50,
                        backgroundColor: AppColor.mainColor,
                        isLoading: addressController.isLoading.value,
                        text: "Submit",
                        onPress: (){
                          if (addressController.formKey.currentState!.validate()) {
                            addressController.addAddress();
                          } else {
                            if (kDebugMode) {
                              print("Error");
                            }
                          }
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
