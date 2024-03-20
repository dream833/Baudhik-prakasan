import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:ssgc/app/modules/bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import 'package:ssgc/app/modules/buy_now/controllers/buy_now_controllers.dart';
import 'package:ssgc/app/modules/checkout/phonepe_payment_controller/phonepe_payment_controller.dart';
import 'package:ssgc/app/widgets/custom_message.dart';
import 'package:ssgc/app/widgets/custom_text_span.dart';
import 'package:ssgc/app/widgets/rating.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';
import 'package:ssgc/app/widgets/text.dart';

import '../../../widgets/Shimmer/checkout_shimmer/checkout_bottom_shimmer.dart';
import '../../../widgets/app_color.dart';
import '../../../widgets/image_loader.dart';
import '../../../widgets/outline_button.dart';
import '../../address/controllers/address_controller.dart';
import '../../address/views/show_address_view.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/views/cart_view.dart';
import '../../checkout/controllers/checkout_controller.dart';
import '../../my_orders/controllers/my_orders_controller.dart';
import '../../profile/views/profile_view.dart';

class BuyNowView extends StatefulWidget {
  const BuyNowView({super.key});

  @override
  State<BuyNowView> createState() => _BuyNowViewState();
}

class _BuyNowViewState extends State<BuyNowView> {
  final checkoutController = Get.put(CheckoutController());
  final addressController = Get.put(AddressController());
  final orderController = Get.put(MyOrdersController());
  bool isItemLoading = false;

  @override
  Widget build(BuildContext context) {
    onRefresh() async {
      addressController.getUserData();
      addressController.getAddress();
    }

    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        title: const Text(
          "Buy now",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 12.h,
              bottom: 12.h,
            ),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 15.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AppImageLoader(
                                    imageUrl: (Get.arguments != null &&
                                            Get.arguments['image'] != null)
                                        ? Get.arguments['image']
                                        : 'assets/images/empty_cart.png',
                                    height: 90,
                                    width: 75)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Book name
                                    SmallText(
                                      text: (Get.arguments != null &&
                                              Get.arguments.containsKey('name'))
                                          ? Get.arguments['name']
                                          : 'Invalid Name',
                                      size: 16.h,
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    // RatingQuantityMrp(index: index),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    const Rating(),
                                    BigText(
                                      text: (Get.arguments != null &&
                                              Get.arguments['price'] != null)
                                          ? "Price: ₹${Get.arguments['price']}"
                                          : 'Invalid Price',
                                      size: 16.h,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Divider(
                                      height: 1.h,
                                    ),
                                    SizedBox(
                                      height: 14.h,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        14.0), // Adjust the radius as needed
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 14,
                      bottom: 14,
                    ),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "My Information",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ProfileView(),
                                  );
                                },
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          CustomTextSpan(
                              title: "Name: ",
                              text:
                                  checkoutController.userName.value.toString()),
                          const SizedBox(
                            height: 6,
                          ),
                          CustomTextSpan(
                              title: "Phone: ",
                              text: checkoutController.userPhone.value),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        14.0), // Adjust the radius as needed
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 14,
                      bottom: 14,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Delivery",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const ShowAddressView());
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Obx(
                          () => addressController.isAddressLoading.value
                              ? const CircularProgressIndicator()
                              : addressController.addressList.isEmpty
                                  ? const Text("No address found")
                                  : CustomTextSpan(
                                      title: "Delivery Address: ",
                                      text:
                                          "${addressController.addressList[0].state.toString()}, "
                                          "${addressController.addressList[0].city.toString()}, "
                                          "${addressController.addressList[0].area.toString()}, "
                                          "${addressController.addressList[0].landmark.toString()}, "
                                          "${addressController.addressList[0].addressLine1.toString()}, "
                                          "${addressController.addressList[0].addressLine2.toString()}, "
                                          "${addressController.addressList[0].postalCode.toString()}"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          14.0), // Adjust the radius as needed
                    ),
                    child: Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 14,
                        bottom: 14,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          RadioListTile<String>(
                            title: const Text('PHONE PAY'),
                            value: 'phonepay',
                            groupValue: checkoutController.selectedValue.value,
                            onChanged: (value) {
                              checkoutController.updateSelectedValue(value!);
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('ccavenu'),
                            value: 'ccavenu',
                            groupValue: checkoutController.selectedValue.value,
                            onChanged: (value) {
                              checkoutController.updateSelectedValue(value!);
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        14.0), // Adjust the radius as needed
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 14.h,
                      bottom: 14.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Order Summary",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        OrderSummary(
                            text: "Order Subtotal",
                            amount: (Get.arguments != null &&
                                    Get.arguments['price'] != null)
                                ? "₹ ${Get.arguments['price'].toString()}"
                                : 'Invalid Price'),
                        const OrderSummary(
                            text: "Discount On Sale", amount: "₹0.00"),
                        // OrderSummary(text: "Delivery fee", amount: "₹40.00"),
                        // OrderSummary(text: "Coin Points Discount", amount: "₹100.00"),
                        const Divider(),
                        OrderSummary(
                            text: "Total Amount",
                            amount: (Get.arguments != null &&
                                    Get.arguments['price'] != null)
                                ? "₹ ${Get.arguments['price'].toString()}"
                                : 'Invalid Price'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(right: 10.w),
        height: 65.h,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: OutlineButton(
                  onPress: () {},
                  text:
                      (Get.arguments != null && Get.arguments['price'] != null)
                          ? "₹ ${Get.arguments['price'].toString()}"
                          : 'Invalid Price'),
            ),
            Expanded(
              flex: 3,
              child: RoundedButton(
                isLoading: orderController.isCreateOrderLoading.value,
                text: 'Proceed to pay',
                onPress: () {
                  if (checkoutController.selectedValue.value == 'phonepay' ||
                      checkoutController.selectedValue.value == 'ccavenu') {
                    // CustomMessage.errorToast('Select payment method is ${checkoutController.selectedValue.value}');
                    startPGTransaction();
                  } else {
                    CustomMessage.errorToast('Please select payment method');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startPGTransaction() async {
    try {
      var response =
          PhonePePaymentSdk.startTransaction(body, callbackUrl, checksum, "");
      response
          .then((val) => {
                setState(() {
                  if (val != null) {
                    String status = val['status'].toString();
                    String error = val['error'].toString();
                    if (status == "SUCCESS") {
                      result = "Flow Success - Status: SUCESSS";

                      orderController.createOrder();
                      Get.offAll(() => BottomNavigationBarView());
                    } else {
                      result = "Flow Success - Status: $status and $error";
                    }
                  } else {
                    result = "Incomplete Flow Error";
                  }
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }
}