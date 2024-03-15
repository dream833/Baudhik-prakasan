import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_color.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/rounded_button.dart';
import '../controllers/address_controller.dart';

class UpdateAddress extends StatelessWidget {
  int id;
  int userId;

  UpdateAddress({
    super.key,
    required this.id,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {

    final addressController = Get.put(AddressController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Address", style: TextStyle(color: AppColor.black,),),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),

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
                    controller: addressController.updateStateController,
                    currentFocus: addressController.stateFocusNode,
                    nextFocus: addressController.cityFocusNode,
                    emptyMessage: "Write your state",
                    label: "State Name",
                  ),

                  CustomTextFormField(
                    controller: addressController.updateCityController,
                    currentFocus: addressController.cityFocusNode,
                    nextFocus: addressController.postCodeFocusNode,
                    emptyMessage: "Write your city name",
                    label: "City Name",
                  ),

                  CustomTextFormField(
                    controller: addressController.updatePostalCodeController,
                    currentFocus: addressController.postCodeFocusNode,
                    nextFocus: addressController.areaFocusNode,
                    emptyMessage: "Write your post code",
                    label: "Post Code",
                  ),

                  CustomTextFormField(
                    controller: addressController.updateAreaController,
                    currentFocus: addressController.areaFocusNode,
                    emptyMessage: "Write your area",
                    label: "Area Name",
                  ),

                  SizedBox(height: 16,),

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
                    controller: addressController.updateLandMarkController,
                    currentFocus: addressController.landMarkFocusNode,
                    nextFocus: addressController.addressLine1FocusNode,
                    emptyMessage: "Land Mark",
                    label: "Land Mark",
                  ),

                  CustomTextFormField(
                    controller: addressController.updateAddressLine1Controller,
                    currentFocus: addressController.addressLine1FocusNode,
                    nextFocus: addressController.addressLine2FocusNode,
                    emptyMessage: "Address Line 1",
                    label: "Address Line 1",
                  ),

                  CustomTextFormField(
                    controller: addressController.updateAddressLine2Controller,
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
                        isLoading: addressController.isUpdateAddressLoading.value ,
                        text:  "Update",
                        onPress: (){
                          if (addressController.formKey.currentState!.validate()) {

                            addressController.updateAddress(id, userId);

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
