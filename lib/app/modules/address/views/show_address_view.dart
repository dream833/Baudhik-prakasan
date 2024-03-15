import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/data/app_image.dart';
import 'package:ssgc/app/modules/address/controllers/address_controller.dart';
import 'package:ssgc/app/modules/address/views/add_address_view.dart';
import 'package:ssgc/app/modules/address/views/update_address_view.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/custom_text_span.dart';
import 'package:ssgc/app/widgets/empty_widget.dart';

class ShowAddressView extends StatelessWidget {
  const ShowAddressView({super.key});

  @override
  Widget build(BuildContext context) {

    final addressController = Get.put(AddressController());

    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        title: const Text("Saved Address",  style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: AppColor.white50,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(()=> addressController.isAddressLoading.value ? const Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          child: Column(
            children: [
              addressController.addressList.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 130.h, bottom: 40.h),
                      child: EmptyView(
                          image: AssetImage(AppImage.empty_cart),
                          mainText: 'No address found',
                          subText: 'You do not add any address yet.',
                      ),
                    )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: addressController.addressList.length,
                        padding: EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index){
                          final address = addressController.addressList[index];
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                            padding: EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 16,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(width: 1, color: Colors.teal,),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.home_rounded,),
                                    const Text("Home"),
                                    if (index == 0) const Text("Default"),
                                    GestureDetector(
                                      onTap: (){
                                        print("Id is ${address.id}");
                                        addressController.deleteAddress(index, address.id);
                                      },
                                      child: const Icon(Icons.delete,),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        navigateToEditAddressPage(context, index);
                                      },
                                      child: const Icon(Icons.edit,),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                CustomTextSpan(title: "User Name: ", text: addressController.username.value),
                                SizedBox(height: 10.h,),
                                Text(
                                  "${address.state.toString()}, "
                                        "${address.city.toString()}, "
                                        "${address.area.toString()}, "
                                        "${address.landmark.toString()}, "
                                        "${address.addressLine1.toString()}, "
                                        "${address.addressLine2.toString()}, "
                                        "${address.postalCode.toString()}"
                                ),
                              ],
                            ),
                          );
                      },
                    ),
              TextButton(
                onPressed: () async {
                  navigateToAddAddressPage(context);
                },
                child: const Text("Add new address",),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> navigateToEditAddressPage(BuildContext context, int index) async {

    final addressController = Get.find<AddressController>();
    final address =  addressController.addressList[index];

    addressController.updateStateController.text = address.state.toString();
    addressController.updateCityController.text = address.city.toString();
    addressController.updateAreaController.text = address.area.toString();
    addressController.updatePostalCodeController.text = address.postalCode.toString();
    addressController.updateLandMarkController.text = address.landmark.toString();
    addressController.updateAddressLine1Controller.text = address.addressLine1.toString();
    addressController.updateAddressLine2Controller.text = address.addressLine2.toString();
    addressController.switchValue.value = address.isDelivery.toString();
    final route = MaterialPageRoute(
      builder: (context) => UpdateAddress(
        id: address.id,
        userId: address.userId,
      ),
    );
    await Navigator.push(context, route);
    addressController.getAddress();
  }

  Future<void> navigateToAddAddressPage(BuildContext context) async {
    final addressController = Get.find<AddressController>();
    final route = MaterialPageRoute(
      builder: (context) => AddAddressView(),
    );
    await Navigator.push(context, route);
    addressController.getAddress();
  }
}
